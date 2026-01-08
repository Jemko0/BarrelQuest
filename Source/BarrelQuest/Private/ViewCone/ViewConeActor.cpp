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
		Result.TraceIndex = StartTraceIndex + i;

		Results.Add(Result);
	}
}

// ===== AViewConeActor Implementation =====

AViewConeActor::AViewConeActor()
{
	PrimaryActorTick.bCanEverTick = true;

	VisionMesh = CreateDefaultSubobject<UProceduralMeshComponent>(TEXT("VisionMesh"));
	RootComponent = CreateDefaultSubobject<USceneComponent>(TEXT("Root"));

	//VisionMesh->AttachToComponent(RootComponent, FAttachmentTransformRules(EAttachmentRule::SnapToTarget, EAttachmentRule::SnapToTarget, EAttachmentRule::SnapToTarget, true));
	VisionMesh->SetupAttachment(RootComponent);
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

	TArray<FVector> AllDirections;
	GenerateTraceDirs(AllDirections);
	TotalTraces = AllDirections.Num();

	if (TotalTraces < 2) return;

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

		FAsyncTask<FVisionConeTraceTask>* Task = new FAsyncTask<FVisionConeTraceTask>(
			ThreadDirections,
			StartLocation,
			VisionRange,
			QueryParams,
			TraceChannel,
			GetWorld(),
			StartIndex
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

	for (float Angle = -HalfAngle; Angle <= HalfAngle; Angle += AngleStep)
	{
		FVector LocalDirection = FVector::ForwardVector.RotateAngleAxis(Angle, FVector::UpVector);

		FVector WorldDirection = ActorRotation.RotateVector(LocalDirection);
		OutDirections.Add(WorldDirection.GetSafeNormal());
	}
}

void AViewConeActor::CheckTasksComplete()
{
	for (FAsyncTask<FVisionConeTraceTask>* Task : ActiveTasks)
	{
		if (!Task->IsDone())
		{
			return;
		}
	}

	ProcessResults();
	bTasksRunning = false;
}

void AViewConeActor::ProcessResults()
{
	CombinedResults.SetNum(TotalTraces);

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

	Vertices.Add(FVector::ZeroVector);
	Normals.Add(UpVector);
	UVs.Add(FVector2D(0.5f, 1.0f));
	VertexColors.Add(FColor::White);

	for (const FVisionTraceResult& Result : CombinedResults)
	{
		Vertices.Add(Result.HitLocation - StartLoc); // Convert to local space.
		Normals.Add(UpVector);

		const float DistanceRatio = Result.Distance / VisionRange;
		VertexColors.Add(Result.bHit ? FColor::Red : FColor::Green);

		UVs.Add(FVector2D(DistanceRatio, 0.f));
	}

	for (int32 i = 1; i < Vertices.Num() - 1; ++i)
	{
		Triangles.Add(0);       // Apex
		Triangles.Add(i + 1);
		Triangles.Add(i);
	}

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
			delete Task; // might be unsafe
		}
	}
	ActiveTasks.Empty();
}
