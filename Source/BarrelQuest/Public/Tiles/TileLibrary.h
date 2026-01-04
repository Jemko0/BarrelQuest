

#pragma once

#include "CoreMinimal.h"
#include "Components/HierarchicalInstancedStaticMeshComponent.h"
#include "Kismet/BlueprintFunctionLibrary.h"
#include "Net/UnrealNetwork.h"
#include "TileLibrary.generated.h"

/**
 * 
 */

//FORWARD DECLARATION
class ATileManager;

UENUM(BlueprintType)
enum class ETileCategory : uint8
{
	FLOOR,
	WALL,
	DOORFRAME,
	WINDOW,
	STAIR,
	PROP,
	ROOF
};

UENUM(BlueprintType)
enum class ETileTextureIndex : uint8
{
	DEBUG,
	WOOD,
	BRICK,
};

UENUM(BlueprintType)
enum class ETileInstanceDataIndex : uint8
{
	ALBEDO_TEX = 0,
	METALLIC_TEX,
	NORMAL_TEX,
	SPECULAR_TEX,
	BASE_METALLIC,
	BASE_ROUGHNESS,
	OBJ_DIRECTION,
	SHOULD_CUT,
	FORCE_CUT,
	MAX
};

USTRUCT(BlueprintType)
struct FTileRenderKey
{
	GENERATED_BODY()
public:
	
	UPROPERTY(BlueprintReadWrite)
	UStaticMesh* Mesh;
	
	UPROPERTY(BlueprintReadWrite)
	UMaterialInterface* Material;

	bool operator==(const FTileRenderKey& Other) const
	{
		return Mesh == Other.Mesh && Material == Other.Material;
	}
};

FORCEINLINE uint32 GetTypeHash(const FTileRenderKey& Key)
{
	return HashCombine(GetTypeHash(Key.Mesh), GetTypeHash(Key.Material));
}

USTRUCT(BlueprintType)
struct FTileDefinition : public FTableRowBase
{
	GENERATED_BODY()
	
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FString Name;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	UMaterialInterface* ParentMaterial;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	UStaticMesh* Mesh;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex Albedo = ETileTextureIndex::DEBUG;
		
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex Specular = ETileTextureIndex::DEBUG;
		
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex Metallic = ETileTextureIndex::DEBUG;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex Normal = ETileTextureIndex::DEBUG;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	float BaseRoughness = 0.5f;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	float BaseMetallic = 0.5f;
	
	//skipping specular because UE Recommends it to be unchanged.
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileCategory Category = ETileCategory::FLOOR;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	float Insulation = 0.2f; //20% Insulation
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	float PlaceTime = 3.0f; //Base time to place tile when building
};

USTRUCT(BlueprintType)
struct FTileRuntimeData
{
	GENERATED_BODY()
	
public:
	FTileRuntimeData() = default;
	FTileRuntimeData(const FTileRuntimeData& Other) = default;
	FTileRuntimeData& operator=(const FTileRuntimeData& Other) = default;
	
	TMap<FName, bool> boolData;

	TMap<FName, float> floatData;

	TMap<FName, int32> intData;
	
	TMap<FName, FString> stringData;
	
	void SetBoolData(FName name, bool b)
	{
		boolData.Add(name, b);
	}
	
	void SetFloatData(FName name, float f)
	{
		floatData.Add(name, f);
	}
	
	void SetIntData(FName name, int32 i)
	{
		intData.Add(name, i);
	}
	
	void SetStringData(FName name, const FString& s)
	{
		stringData.Add(name, s);
	}
};

UENUM(BlueprintType)
enum class ETileDirection : uint8
{
	NORTH,
	EAST,
	SOUTH,
	WEST,
};

USTRUCT(BlueprintType)
struct FRoomValue
{
	GENERATED_BODY()
public:
	FRoomValue() = default;
	
	FRoomValue(FIntVector tile)
	{
		AddRoomTile(tile);
	}
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<FIntVector> tiles;
	
	void AddRoomTile(FIntVector tile)
	{
		tiles.AddUnique(tile);
	}
	
	void RemoveRoomTile(FIntVector tile)
	{
		tiles.Remove(tile);
	}
};

USTRUCT(BlueprintType)
struct FTileObject
{
	GENERATED_BODY()
	
public:
	FTileObject() = default;
	FTileObject(const FTileObject& Other) = default;
	FTileObject& operator=(const FTileObject& Other) = default;
	
	UPROPERTY(BlueprintReadWrite)
	FName ID;
	
	UPROPERTY(BlueprintReadWrite)
	ETileDirection Direction;
	
	UPROPERTY(BlueprintReadWrite)
	FTileRuntimeData runtimeData;
	
	UPROPERTY(BlueprintReadOnly)
	int32 RenderInstanceIndex = -1;
};

USTRUCT(BlueprintType)
struct FSquareTile
{
	GENERATED_BODY()
	
	FSquareTile() = default;
	FSquareTile(const FSquareTile& Other) = default;
	FSquareTile& operator=(const FSquareTile& Other) = default;
	
protected:
	///DONT USE THIS TO SET VALUES
	TArray<FTileObject> objects;
	
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	uint8 wallMask = 0x0;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	uint8 flags = 0x0;
	
	///Returns a copy of the objects array
	TArray<FTileObject>& GetObjectsOnSquare()
	{
		return objects;
	}
	
	void SetWall(ETileDirection direction, bool wallState)
	{
		uint8 bit = 1 << (uint8)direction;
		if (wallState)
		{
			wallMask |= bit;
		}
		else
		{
			wallMask &= ~bit;
		}
	}

	bool HasWall(ETileDirection direction) const
	{
		return (wallMask & (1 << (uint8)direction)) != 0;
	}
	
	int AddObject(const FTileObject& Object)
	{
		return objects.Add(Object);
	}
	
	void RemoveObjectByIndex(const int i)
	{
		objects.RemoveAt(i);
	}
	
	bool HasObjectOfCategory(ETileCategory category, ATileManager* mgr) const;
	bool HasObjectOfDirection(ETileDirection direction) const;
	
	static constexpr uint16 FLAG_WALKABLE = 1 << 0; // bit 0 reserved for walkable
	static constexpr uint16 FLAG_HAS_CEILING = 1 << 1; // bit 1 reserved for hasCeiling
	
	void SetWalkable(bool walkable)
	{
		if (walkable)
			flags |= FLAG_WALKABLE;   // turn the bit on
		else
			flags &= ~FLAG_WALKABLE;  // turn the bit off
	}
	
	bool IsWalkable() const
	{
		return (flags & FLAG_WALKABLE) != 0;
	}
	
	void SetHasCeiling(bool hasCeiling)
	{
		if (hasCeiling)
			flags |= FLAG_HAS_CEILING;
		else
			flags &= ~FLAG_HAS_CEILING;
	}
	
	bool HasCeiling() const
	{
		return (flags & FLAG_HAS_CEILING) != 0;
	}
};


USTRUCT(BlueprintType)
struct FTileEntry
{
	GENERATED_BODY()
	
public:
	FIntVector Location;
	FSquareTile Tile;
};

UCLASS()
class BARRELQUEST_API UTileLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
	
public:
	UFUNCTION(BlueprintCallable)
	static void SetRuntimeBoolProperty(FName prop, bool v, FTileRuntimeData& runtimeData);
	
	UFUNCTION(BlueprintCallable)
	static void SetRuntimeFloatProperty(FName prop, float v, FTileRuntimeData& runtimeData);
	
	UFUNCTION(BlueprintCallable)
	static void SetRuntimeIntProperty(FName prop, int32 v, FTileRuntimeData& runtimeData);
	
	UFUNCTION(BlueprintCallable)
	static void SetRuntimeStringProperty(FName prop, FString v, FTileRuntimeData& runtimeData);
	
	UFUNCTION(BlueprintCallable)
	static bool GetRuntimeBoolProperty(FName Key, FTileRuntimeData& runtimeData);
	
	UFUNCTION(BlueprintCallable)
	static float GetRuntimeFloatProperty(FName Key, FTileRuntimeData& runtimeData);
	
	UFUNCTION(BlueprintCallable)
	static int GetRuntimeIntProperty(FName Key, FTileRuntimeData& runtimeData);
	
	UFUNCTION(BlueprintCallable)
	static FString GetRuntimeStringProperty(FName Key, FTileRuntimeData& runtimeData);
	
	UFUNCTION(BlueprintCallable)
	static void SetSquareWalkable(FSquareTile& sq, bool newWalkable);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static bool SquareIsWalkable(FSquareTile& sq, bool newWalkable);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FIntVector2 WorldToChunkPosition(FVector worldPosition);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FIntVector WorldToLocalChunkTilePosition(FVector worldPosition, ATileChunk* chunk);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FIntVector WorldToTilePosition(FVector worldPosition);
	
	///Returns the world position of a chunk. Z is always 0
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FVector ChunkToWorldPosition(FIntVector2 chunkPosition);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FVector TileToWorldPosition(FIntVector tilePosition);
	
	UFUNCTION(BlueprintCallable)
	static int AddObjectToSquare(FTileObject object, FSquareTile& squareTile);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static TArray<FTileObject>& GetObjectsOnSquare(UPARAM(Ref) FSquareTile& square);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FVector GetTileSize();
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FIntVector GetChunkSize();
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static bool CountsAsWall(ETileCategory cat);
};
