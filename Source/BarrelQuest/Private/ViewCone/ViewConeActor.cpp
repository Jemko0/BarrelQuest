#include "ViewCone/ViewConeActor.h"
#include "DrawDebugHelpers.h"
#include "Engine/World.h"

// ===== FVisionConeTraceTask Implementation =====

void FVisionConeTraceTask::DoWork()
{
	Results.Empty();
	if (!World)
	{
		return;
	}

	// Perform line traces for the batch of directions assigned to this task.
	for (int32 i = 0; i < TraceDirections.Num(); ++i)
	{
		const FVector EndLocation = StartLocation + (TraceDirections[i] * MaxDistance);
		FHitResult HitResult;
		FVisionTraceResult Result;

		const bool bHit = World->LineTraceSingleByChannel(
			HitResult,
			StartLocation,
			EndLocation,
			Channel,
			QueryParams
		);

		Result.bHit = bHit;
		Result.HitLocation = bHit ? HitResult.Location : EndLocation;
		Result.Distance = bHit ? HitResult.Distance : MaxDistance;
		Result.TraceIndex = StartTraceIndex + i; // Store the original index for sorting later.

		Results.Add(Result);
	}
}

// ===== AViewConeActor Implementation =====

AViewConeActor::AViewConeActor()
{
	PrimaryActorTick.bCanEverTick = true;

	VisionMesh = CreateDefaultSubobject<UProceduralMeshComponent>(TEXT("VisionMesh"));
	RootComponent = CreateDefaultSubobject<USceneComponent>(TEXT("Root"));

	VisionMesh->AttachToComponent(RootComponent, FAttachmentTransformRules(EAttachmentRule::SnapToTarget, EAttachmentRule::SnapToTarget, EAttachmentRule::SnapToTarget, true));

	VisionMesh->bUseAsyncCooking = true;
	VisionMesh->SetCastShadow(false);

	VisionMesh->SetRenderInMainPass(false);
	VisionMesh->bRenderInDepthPass = false;
	VisionMesh->SetRenderCustomDepth(true);
	VisionMesh->SetCustomDepthStencilValue(255);
	VisionMesh->SetCustomDepthStencilWriteMask(ERendererStencilMask::ERSM_255);
}

void AViewConeActor::BeginPlay()
{
	Super::BeginPlay();

	VisionMesh->bUseAsyncCooking = true;
	VisionMesh->SetCastShadow(false);
	VisionMesh->SetRenderInMainPass(false);
	VisionMesh->bRenderInDepthPass = false;
	VisionMesh->SetRenderCustomDepth(true);
	VisionMesh->SetCustomDepthStencilValue(255);
	VisionMesh->SetCustomDepthStencilWriteMask(ERendererStencilMask::ERSM_255);
}

void AViewConeActor::Tick(float DeltaTime)
{
	Super::Tick(DeltaTime);

	// Either check for completion of running tasks or start a new trace cycle.
	if (bTasksRunning)
	{
		CheckTasksComplete();
	}
	else
	{
		StartVisionTrace();
	}
}

void AViewConeActor::StartVisionTrace()
{
	ClearActiveTasks();
	CombinedResults.Empty();

	// Generate all trace directions based on VisionAngle and AngleStep.
	TArray<FVector> AllDirections;
	GenerateTraceDirs(AllDirections);
	TotalTraces = AllDirections.Num();

	if (TotalTraces < 2) return;

	// Set up collision query parameters, ignoring the actor itself.
	FCollisionQueryParams QueryParams;
	QueryParams.AddIgnoredActor(this);
	QueryParams.bTraceComplex = false;
	const FVector StartLocation = GetActorLocation();

	const int32 NumTasks = FMath::CeilToInt((float)TotalTraces / (float)TracesPerThread);
	for (int32 i = 0; i < NumTasks; ++i)
	{
		const int32 StartIndex = i * TracesPerThread;
		const int32 EndIndex = FMath::Min(StartIndex + TracesPerThread, TotalTraces);

		TArray<FVector> ThreadDirections;
		for (int32 j = StartIndex; j < EndIndex; ++j)
		{
			ThreadDirections.Add(AllDirections[j]);
		}

		// Create and start the async task.
		FAsyncTask<FVisionConeTraceTask>* Task = new FAsyncTask<FVisionConeTraceTask>(
			ThreadDirections,
			StartLocation,
			VisionRange,
			QueryParams,
			TraceChannel,
			GetWorld(),
			StartIndex // Pass the starting index to keep results ordered.
		);
		Task->StartBackgroundTask();
		ActiveTasks.Add(Task);
	}

	bTasksRunning = true;
}

void AViewConeActor::GenerateTraceDirs(TArray<FVector>& OutDirections)
{
	OutDirections.Empty();

	const FRotator ActorRotation = GetActorRotation();
	const float HalfAngle = VisionAngle * 0.5f;

	// Create a fan of trace directions in local space, then transform to world space.
	for (float Angle = -HalfAngle; Angle <= HalfAngle; Angle += AngleStep)
	{
		// Generate direction in local space (forward = X-axis, rotate around Z-axis)
		FVector LocalDirection = FVector::ForwardVector.RotateAngleAxis(Angle, FVector::UpVector);
		// Transform to world space using actor rotation
		FVector WorldDirection = ActorRotation.RotateVector(LocalDirection);
		OutDirections.Add(WorldDirection.GetSafeNormal());
	}
}

void AViewConeActor::CheckTasksComplete()
{
	// Poll tasks to see if they are all complete.
	for (FAsyncTask<FVisionConeTraceTask>* Task : ActiveTasks)
	{
		if (!Task->IsDone())
		{
			return; // Exit if any task is still running.
		}
	}

	// If all tasks are done, process the combined results.
	ProcessResults();
	bTasksRunning = false;
}

void AViewConeActor::ProcessResults()
{
	// Ensure the results array is the correct size.
	CombinedResults.SetNum(TotalTraces);

	// Gather results from all tasks and place them in the correct order using TraceIndex.
	for (FAsyncTask<FVisionConeTraceTask>* Task : ActiveTasks)
	{
		const TArray<FVisionTraceResult>& TaskResults = Task->GetTask().GetResults();
		for (const FVisionTraceResult& Result : TaskResults)
		{
			if (Result.TraceIndex >= 0 && Result.TraceIndex < TotalTraces)
			{
				CombinedResults[Result.TraceIndex] = Result;
			}
		}
	}

	// Perform debug drawing if enabled.
	if (bDebugDraw)
	{
		const FVector StartLoc = GetActorLocation();
		for (const FVisionTraceResult& Result : CombinedResults)
		{
			FColor LineColor = Result.bHit ? FColor::Red : FColor::Green;
			DrawDebugLine(GetWorld(), StartLoc, Result.HitLocation, LineColor, false, 0.0f, 0, 1.0f);
			if (Result.bHit)
			{
				DrawDebugSphere(GetWorld(), Result.HitLocation, 5.0f, 8, FColor::Yellow, false, 0.0f);
			}
		}
	}

	// Generate the procedural mesh from the final, ordered results.
	CreateVisionMesh();

	ClearActiveTasks();
}

void AViewConeActor::CreateVisionMesh()
{
	if (CombinedResults.Num() < 2)
	{
		VisionMesh->ClearAllMeshSections();
		return;
	}

	TArray<FVector> Vertices;
	TArray<int32> Triangles;
	TArray<FVector> Normals;
	TArray<FVector2D> UVs;
	TArray<FColor> VertexColors;
	TArray<FProcMeshTangent> Tangents;

	const FVector StartLoc = GetActorLocation();
	const FVector UpVector = GetActorUpVector();

	// Add the apex vertex at the actor's location (origin in local space).
	Vertices.Add(FVector::ZeroVector);
	Normals.Add(UpVector);
	UVs.Add(FVector2D(0.5f, 1.0f));
	VertexColors.Add(FColor::White);

	// Add vertices for each trace hit point.
	for (const FVisionTraceResult& Result : CombinedResults)
	{
		Vertices.Add(Result.HitLocation - StartLoc); // Convert to local space.
		Normals.Add(UpVector); // Simple normal pointing up.

		const float DistanceRatio = Result.Distance / VisionRange;
		VertexColors.Add(Result.bHit ? FColor::Red : FColor::Green);

		// UVs can be calculated based on angle, but a simple distance-based approach works too.
		UVs.Add(FVector2D(DistanceRatio, 0.f));
	}

	// Create triangles by fanning out from the apex.
	// Each pair of adjacent vertices from the traces forms a triangle with the apex.
	for (int32 i = 1; i < Vertices.Num() - 1; ++i)
	{
		Triangles.Add(0);       // Apex
		Triangles.Add(i + 1);
		Triangles.Add(i);
	}

	// Create or update the mesh section with the new geometry.
	VisionMesh->CreateMeshSection(0, Vertices, Triangles, Normals, UVs, VertexColors, Tangents, true);

	if (VisionMaterial)
	{
		VisionMesh->SetMaterial(0, VisionMaterial);
	}

	VisionMesh->SetWorldRotation(FRotator(0.f, 0.f, 0.f));
}

void AViewConeActor::ClearActiveTasks()
{
	for (FAsyncTask<FVisionConeTraceTask>* Task : ActiveTasks)
	{
		if (Task)
		{
			Task->EnsureCompletion();
			delete Task;
		}
	}
	ActiveTasks.Empty();
}
