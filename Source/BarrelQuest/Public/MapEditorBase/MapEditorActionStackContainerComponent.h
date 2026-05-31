// 

#pragma once

#include "CoreMinimal.h"
#include "Components/ActorComponent.h"
#include "MapEditorBase/ActionStack/MapEditorActionStackLibrary.h"
#include "MapEditorActionStackContainerComponent.generated.h"

class ATileManager;

UCLASS(ClassGroup=(Custom), meta=(BlueprintSpawnableComponent))
class BARRELQUEST_API UMapEditorActionStackContainerComponent : public UActorComponent
{
	GENERATED_BODY()

public:
	// Sets default values for this component's properties
	UMapEditorActionStackContainerComponent();

	UPROPERTY(BlueprintReadWrite, EditAnywhere, Category="Map Editor|Action Stack")
	int32 MaxUndoActions = 100;

	UPROPERTY(BlueprintReadOnly, Category="Map Editor|Action Stack")
	TArray<FMapEditAction> UndoStack;

	UPROPERTY(BlueprintReadOnly, Category="Map Editor|Action Stack")
	TArray<FMapEditAction> RedoStack;

protected:
	// Called when the game starts
	virtual void BeginPlay() override;

public:
	// Called every frame
	virtual void TickComponent(float DeltaTime, ELevelTick TickType,
	                           FActorComponentTickFunction* ThisTickFunction) override;

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	bool CommitAppliedAction(const FMapEditAction& Action);

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	bool CommitAppliedSnapshots(const FString& Label, const TArray<FMapSquareSnapshot>& BeforeSnapshots,
		const TArray<FMapSquareSnapshot>& AfterSnapshots);

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	bool CommitAndApplyAction(ATileManager* TileManager, const FMapEditAction& Action);

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	bool Undo(ATileManager* TileManager);

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	bool Redo(ATileManager* TileManager);

	UFUNCTION(BlueprintCallable, Category="Map Editor|Action Stack")
	void ClearHistory();

	UFUNCTION(BlueprintPure, Category="Map Editor|Action Stack")
	bool CanUndo() const;

	UFUNCTION(BlueprintPure, Category="Map Editor|Action Stack")
	bool CanRedo() const;

	UFUNCTION(BlueprintPure, Category="Map Editor|Action Stack")
	FString GetUndoLabel() const;

	UFUNCTION(BlueprintPure, Category="Map Editor|Action Stack")
	FString GetRedoLabel() const;

private:
	void TrimUndoStack();
};
