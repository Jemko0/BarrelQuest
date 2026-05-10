#pragma once

#include "CoreMinimal.h"
#include "Crafting/CraftingLibrary.h"
#include "Kismet/BlueprintFunctionLibrary.h"
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
	DECAL,
	HALF_WALL,
	WALL,
	DOORFRAME,
	WINDOW,
	STAIR,
	PROP,
	ROOF,
	ROOF_WALL,
};

UENUM(BlueprintType)
enum class ETileTextureIndex : uint8
{
	DEBUG,
	WOOD,
	BRICK_TINTABLE,
	STONE,
	METAL,
	ASPHALT_TIRE_LINES,
	ASPHALT_SMOOTHED,
	ASPHALT_NO_TIRE_LINES,
	SIDEWALK,
	CARPET,
	MESH_FENCE,
	WOOD_PLANKS_TINTABLE,
	TILED_FLOOR,
	
	ROOF_RED,
	ROOF_GRAY,
	
	//road lines
	ROAD_LINES_THICK_TOP,
	ROAD_LINES_DECAL_STOP,
	ROAD_LINES_DECAL_SPEED50,
	ROAD_LINES_DECAL_SPEED30,
	ROAD_LINES_DECAL_BUS,
	ROAD_LINES_DECAL_ARROW_STRAIGHT,
	ROAD_LINES_DECAL_ARROW_LEFT,
	ROAD_LINES_DASHED_TINY,
	ROAD_LINES_DASHED_SMALL,
	ROAD_LINES_DASHED_LARGE,
	ROAD_LINES_CONTINUOUS_THICK_TOP,
	ROAD_LINES_CONTINUOUS_SINGLE_LEFT_TOP,
	ROAD_LINES_CONTINUOUS_SINGLE_LEFT,
	ROAD_LINES_CONTINUOUS_SINGLE,
	ROAD_LINES_CONTINUOUS_DOUBLE,
	
	PATTERN_WALL,
	PATTERN_WALL_LINE,
	PATTERN_WALL_LINE_STRIPES,

	PROP_FENCE_SHORT,
	PROP_FENCE_BROWN,
	
	CUSTOM = UINT8_MAX
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
	TINT_R,
	TINT_G,
	TINT_B,
	HUE_SHIFT,
	DARKENED,
	MIRRORED,
	INT_ALBEDO_TEX,
	INT_METALLIC_TEX,
	INT_NORMAL_TEX,
	INT_SPECULAR_TEX,
	INT_TINT_R,
	INT_TINT_G,
	INT_TINT_B,
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

USTRUCT(BlueprintType)
struct FTileObjectFeature
{
	GENERATED_BODY()
public:
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	TSubclassOf<USceneComponent> FeatureClass;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	FName FeatureName;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	FName AttachSocket;
	
	UPROPERTY(EditAnywhere, BlueprintReadWrite)
	FTransform RelativeTransform;
};

USTRUCT(BlueprintType)
struct FStoredFeature
{
	GENERATED_BODY()
	
	FName FeatureName;
	FIntVector OwningSquare;
	int32 OwningObject;
	USceneComponent* ComponentPtr = nullptr;
	
	FStoredFeature() = default;
};

USTRUCT(BlueprintType)
struct FStoredFeatureArray
{
	GENERATED_BODY()
	
	TArray<FStoredFeature> features;
};

FORCEINLINE uint32 GetTypeHash(const FTileRenderKey& Key)
{
	return HashCombine(GetTypeHash(Key.Mesh), GetTypeHash(Key.Material));
}

USTRUCT(BlueprintType)
struct FTileTextureIndices : public FTableRowBase
{
	GENERATED_BODY()
	
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex Albedo = ETileTextureIndex::DEBUG;
		
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex Specular = ETileTextureIndex::DEBUG;
		
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex Metallic = ETileTextureIndex::DEBUG;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex Normal = ETileTextureIndex::DEBUG;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex InteriorAlbedo = ETileTextureIndex::DEBUG;
		
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex InteriorSpecular = ETileTextureIndex::DEBUG;
		
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex InteriorMetallic = ETileTextureIndex::DEBUG;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileTextureIndex InteriorNormal = ETileTextureIndex::DEBUG;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	float BaseRoughness = 1.0f;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	float BaseMetallic = 1.0f;
};

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
	FTileTextureIndices TextureProperties = FTileTextureIndices();
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FLinearColor tint = FLinearColor(1.0f, 1.0f, 1.0f, 1.0f);
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FLinearColor InteriorTint = FLinearColor(1.0f, 1.0f, 1.0f, 1.0f);
	
	//skipping specular because UE docs recommend it to be unchanged.
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	ETileCategory Category = ETileCategory::FLOOR;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	float Insulation = 0.2f; //20%
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	float PlaceTime = 3.0f; //Base time in seconds to place tile when building
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TEnumAsByte<ECollisionChannel> ObjectType = ECC_GameTraceChannel6;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TMap<FName, FString> DefaultRuntimeData;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TArray<FTileObjectFeature> DefaultFeatures;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	TMap<FName, FCraftingRecipeIngredient> CraftingRecipe;
};

USTRUCT(BlueprintType)
struct FRuntimeDataQueryResult
{
	GENERATED_BODY()
	
public:
	FRuntimeDataQueryResult() : data(FString(TEXT("null"))), index(-1), valid(false) {};
	FRuntimeDataQueryResult(const int32& newIdx, const FString& newData) : data(newData), index(newIdx), valid(true) {};
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	FString data;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere)
	int32 index;
	
	UPROPERTY(BlueprintReadOnly, VisibleAnywhere)
	bool valid;
};

DECLARE_MULTICAST_DELEGATE_TwoParams(FOnRuntimeDataChanged, FName, const FString&);
DECLARE_MULTICAST_DELEGATE_FourParams(FOnObjectRuntimeDataChanged, FName, const FString&, FIntVector, int32);
DECLARE_MULTICAST_DELEGATE_OneParam(FOnRuntimeDataRemoved, FName);

USTRUCT(BlueprintType)
struct FTileRuntimeData
{
	GENERATED_BODY()
protected:
	UPROPERTY(BlueprintReadOnly, VisibleAnywhere, SaveGame, NotReplicated)
	TMap<FName, int32> indexLookup;
	
public:
	UPROPERTY(BlueprintReadOnly, VisibleAnywhere, SaveGame)
	TArray<FString> runtimeData;
	
	FOnRuntimeDataChanged OnChanged;
	FOnRuntimeDataRemoved OnRemoved;
	
	///Sets a runtime value, if key doesnt exist, it gets added
	void SetValue(FName Key, FString Value);
	
	///Removes a runtime value, if key doesnt exist, returns false
	bool RemoveValue(FName Key);
	
	TArray<FName> Keys() const;
	const TArray<FString>& Values() const;
	
	///Gets a runtime value, if key doesnt exist, returns query result with valid == false 
	FRuntimeDataQueryResult GetValue(FName Key) const;
	
	void BuildLookup();
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
struct FBuildingValue
{
	GENERATED_BODY()
	
public:
	FBuildingValue() = default;
	
	TSet<int> RoomIDs;
	TArray<FBox> BoundingBoxes;
	FBox MainBounds;
	
	void AddRoomID(const int& roomID)
	{
		RoomIDs.Add(roomID);
	}
	
	void RemoveRoomID(const int& roomID)
	{
		RoomIDs.Remove(roomID);
	}
	
	void CalculateBounds(ATileManager* mgr);
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
	
	FRoomValue(FIntVector tile, bool exit)
	{
		AddRoomTile(tile);
		if (exit)
		{
			AddExitTile(tile);
		}
	}
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	TSet<FIntVector> tiles;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	TSet<FIntVector> exits;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	TSet<FIntVector> ceilings;
	
	void AddExitTile(const FIntVector& tile)
	{
		AddRoomTile(tile);
		exits.Add(tile);
	}
	
	void RemoveExitTile(const FIntVector& tile)
	{
		exits.Remove(tile);
	}
	
	void AddRoomTile(FIntVector tile)
	{
		if (tiles.Contains(tile)) return;
		tiles.Add(tile);
	}
	
	void RemoveRoomTile(FIntVector tile)
	{
		if (!tiles.Contains(tile)) return;
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
	
	UPROPERTY(BlueprintReadWrite, SaveGame)
	FName ID;
	
	UPROPERTY(BlueprintReadWrite, SaveGame)
	ETileDirection Direction;
	
	UPROPERTY(BlueprintReadWrite, VisibleAnywhere, SaveGame)
	FTileRuntimeData runtimeData;
	
	UPROPERTY(BlueprintReadWrite, SaveGame)
	TArray<FTileObjectFeature> Features;
	
	UPROPERTY(BlueprintReadOnly)
	int32 RenderInstanceIndex = -1;
	
	UPROPERTY(BlueprintReadWrite, SaveGame)
	bool Mirrored = false;
};

USTRUCT(BlueprintType)
struct FSquareTile
{
	GENERATED_BODY()
	
	FSquareTile() = default;
	
	FSquareTile(FIntVector globalPos)
	{
		globalPosition = globalPos;
	}
	
	FSquareTile(const FSquareTile& Other) = default;
	FSquareTile& operator=(const FSquareTile& Other) = default;
	
protected:
	///DONT USE THIS TO SET VALUES
	UPROPERTY(BlueprintReadOnly, EditAnywhere, SaveGame)
	TArray<FTileObject> objects;
	
public:
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	uint8 wallMask = 0x0;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	uint8 flags = 0x0;
	
	UPROPERTY(BlueprintReadWrite, EditAnywhere, SaveGame)
	FIntVector globalPosition;
	
	///Returns a copy of the objects array
	TArray<FTileObject>& GetObjectsOnSquare()
	{
		return objects;
	}
	
	const TArray<FTileObject>& GetReadOnlyObjects() const
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
	
	void AddObjects(const TArray<FTileObject>& Objects)
	{
		for (const FTileObject& Object : Objects)
		{
			AddObject(Object);
		}
	}
	
	void RemoveObjectByIndex(const int i)
	{
		objects.RemoveAt(i);
	}
	
	bool HasObjectOfCategory(ETileCategory category, ATileManager* mgr) const;
	bool HasObjectOfDirection(ETileDirection direction) const;
	
	static constexpr uint16 FLAG_WALKABLE = 1 << 0; // bit 0 reserved for walkable
	static constexpr uint16 FLAG_HAS_CEILING = 1 << 1; // bit 1 reserved for hasCeiling
	static constexpr uint16 FLAG_INSIDE_SQUARE = 1 << 2; // bit 2 reserved for insideSquare
	
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
	
	void SetInsideSquare(bool insideSquare)
	{
		if (insideSquare)
			flags |= FLAG_INSIDE_SQUARE;
		else
			flags &= ~FLAG_INSIDE_SQUARE;
	}
	
	bool IsInsideSquare() const
	{
		return (flags & FLAG_INSIDE_SQUARE) != 0;
	}
};

USTRUCT(BlueprintType)
struct FTileSearchFilter
{
	GENERATED_BODY()
	
public:
	TSet<ETileCategory> IncludeCategories;
	int32 minZLevel = -1;
	
	void IncludeCategory(ETileCategory Category)
	{
		IncludeCategories.Add(Category);
	}
	
	bool IsIncludedCategory(const FTileDefinition& TileDef)
	{
		return IncludeCategories.Contains(TileDef.Category) || IncludeCategories.Num() < 1;
	}
	
	void SetMinZLevel(int32 Z)
	{
		minZLevel = Z;
	}
};

USTRUCT(BlueprintType)
struct FTileSyncPacket
{
	GENERATED_BODY()

	UPROPERTY()
	FIntVector Position;

	UPROPERTY()
	TArray<FTileObject> Objects;
};

UCLASS()
class BARRELQUEST_API UTileLibrary : public UBlueprintFunctionLibrary
{
	GENERATED_BODY()
	
public:
	UFUNCTION(BlueprintCallable)
	static void SetSquareWalkable(FSquareTile& sq, bool newWalkable);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static bool SquareIsWalkable(FSquareTile& sq, bool newWalkable);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FIntVector2 WorldToChunkPosition(FVector worldPosition);
	
	///Wraps world coords into a chunk local coordinate
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FIntVector WorldToLocalChunkTilePosition(FVector worldPosition, ATileChunk* chunk);
	
	///Returns the tile position of a world position
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FIntVector WorldToTilePosition(FVector worldPosition);
	
	///Returns the world position of a chunk. Z is always 0
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FVector ChunkToWorldPosition(FIntVector2 chunkPosition);
	
	///Returns the world position of a tile
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
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static ETileDirection GetOppositeDirection(const ETileDirection& inDir);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static FIntVector GetTileIndexOffsetFromDirection(const ETileDirection& inDir);
	
	UFUNCTION(BlueprintCallable, BlueprintPure)
	static bool IsSquareExitSquare(ATileManager* mgr, const FSquareTile& square, FIntVector squarePos, int currentRoomID);
	
	///Draws tile squares as debug boxes, will not work in non debug builds
	UFUNCTION(BlueprintCallable)
	static void DrawTileSquaresFromSet(const TSet<FIntVector>& squares);
	
	UFUNCTION(BlueprintCallable)
	static void DrawTileSquaresFromArray(const TArray<FIntVector>& squares);
	
	UFUNCTION(BlueprintCallable)
	static FTileRuntimeData& SetRuntimeDataValue(UPARAM(ref) FTileRuntimeData& runtimeData, FName Key, FString Value);
	
	UFUNCTION(BlueprintCallable)
	static FTileRuntimeData ConvertMapRuntimeDataToTileRuntimeData(const TMap<FName, FString>& Map);
	
	UFUNCTION(BlueprintCallable)
	static TArray<FString> ParseRuntimeData(UPARAM(ref) FTileRuntimeData& runtimeData);
};
