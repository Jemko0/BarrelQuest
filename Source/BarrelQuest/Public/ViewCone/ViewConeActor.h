#pragma once

#include "CoreMinimal.h"
#include "GameFramework/Actor.h"
#include "Async/AsyncWork.h"
#include "ProceduralMeshComponent.h"
#include "ViewConeActor.generated.h"

USTRUCT(BlueprintType)
struct FVisionTraceResult
{
	GENERATED_BODY()

	UPROPERTY(BlueprintReadOnly)
	FVector HitLocation;

	UPROPERTY(BlueprintReadOnly)
	bool bHit;

	UPROPERTY(BlueprintReadOnly)
	float Distance;

	int32 TraceIndex;

	FVisionTraceResult()
		: HitLocation(FVector::ZeroVector)
		, bHit(false)
		, Distance(0.0f)
		, TraceIndex(-1)
	{
	}
};

class FVisionConeTraceTask : public FNonAbandonableTask
{
	friend class FAutoDeleteAsyncTask<FVisionConeTraceTask>;

public:
	FVisionConeTraceTask(
		const TArray<FVector>& InTraceDirections,
		const FVector& InStartLocation,
		float InMaxDistance,
		const FCollisionQueryParams& InQueryParams,
		const ECollisionChannel TraceChannel,
		UWorld* InWorld,
		int32 InStartTraceIndex = 0
	)
		: TraceDirections(InTraceDirections)
		, StartLocation(InStartLocation)
		, MaxDistance(InMaxDistance)
		, QueryParams(InQueryParams)
		, Channel(TraceChannel)
		, World(InWorld)
		, StartTraceIndex(InStartTraceIndex)
	{
	}

	// profilingsss
	FORCEINLINE TStatId GetStatId() const
	{
		RETURN_QUICK_DECLARE_CYCLE_STAT(FVisionConeTraceTask, STATGROUP_ThreadPoolAsyncTasks);
	}

	void DoWork();

	const TArray<FVisionTraceResult>& GetResults() const { return Results; }

protected:
	TArray<FVector> TraceDirections;
	FVector StartLocation;
	float MaxDistance;
	FCollisionQueryParams QueryParams;
	ECollisionChannel Channel;
	UWorld* World;
	int32 StartTraceIndex;
	TArray<FVisionTraceResult> Results;
};

/**
 * An actor that generates a procedural mesh representing a cone of vision.
 * It uses asynchronous line traces to detect obstacles and builds the mesh based on hit results.
 */
UCLASS()
class AViewConeActor : public AActor
{
	GENERATED_BODY()

public:
	AViewConeActor();

	virtual void Tick(float DeltaTime) override;

protected:
	virtual void BeginPlay() override;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Vision Cone", meta = (ToolTip = "Number of traces to process per asynchronous task."))
	int32 TracesPerThread = 64;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Vision Cone", meta = (ToolTip = "The maximum distance of the vision cone."))
	float VisionRange = 5000.0f;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Vision Cone", meta = (ToolTip = "The total horizontal angle of the vision cone in degrees."))
	float VisionAngle = 90.0f;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Vision Cone", meta = (ToolTip = "The angular separation in degrees between each trace. Smaller values mean more traces and a denser mesh."))
	float AngleStep = 1.0f;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Vision Cone", meta = (ToolTip = "If enabled, draws debug lines and spheres for each trace."))
	bool bDebugDraw = false;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Vision Cone", meta = (ToolTip = "The material to apply to the generated vision mesh."))
	UMaterialInterface* VisionMaterial = nullptr;

	UPROPERTY(VisibleAnywhere, BlueprintReadOnly, Category = "Vision Cone")
	UProceduralMeshComponent* VisionMesh;

	UPROPERTY(EditAnywhere, BlueprintReadWrite, Category = "Vision Cone")
	TEnumAsByte<ECollisionChannel> TraceChannel = ECC_Visibility;

private:
	void StartVisionTrace();
	void GenerateTraceDirs(TArray<FVector>& OutDirections);
	void CheckTasksComplete();
	void ProcessResults();
	void CreateVisionMesh();

	void ClearActiveTasks();

	TArray<FAsyncTask<FVisionConeTraceTask>*> ActiveTasks;
	TArray<FVisionTraceResult> CombinedResults;
	int32 TotalTraces = 0;
	bool bTasksRunning = false;
};
