#include "MapEditorBase/MapEditorActionStackContainerComponent.h"

#include "Tiles/TileManager.h"

UMapEditorActionStackContainerComponent::UMapEditorActionStackContainerComponent()
{
	PrimaryComponentTick.bCanEverTick = false;
}

void UMapEditorActionStackContainerComponent::BeginPlay()
{
	Super::BeginPlay();
}

void UMapEditorActionStackContainerComponent::TickComponent(float DeltaTime, ELevelTick TickType,
	FActorComponentTickFunction* ThisTickFunction)
{
	Super::TickComponent(DeltaTime, TickType, ThisTickFunction);
}

bool UMapEditorActionStackContainerComponent::CommitAppliedAction(const FMapEditAction& Action)
{
	if (Action.Changes.IsEmpty())
	{
		return false;
	}

	UndoStack.Add(Action);
	TrimUndoStack();
	RedoStack.Empty();
	return true;
}

bool UMapEditorActionStackContainerComponent::CommitAppliedSnapshots(const FString& Label,
	const TArray<FMapSquareSnapshot>& BeforeSnapshots, const TArray<FMapSquareSnapshot>& AfterSnapshots)
{
	FMapEditAction Action;
	if (!UMapEditorActionStackLibrary::MakeActionFromSnapshots(Label, BeforeSnapshots, AfterSnapshots, Action))
	{
		return false;
	}

	return CommitAppliedAction(Action);
}

bool UMapEditorActionStackContainerComponent::CommitAndApplyAction(ATileManager* TileManager, const FMapEditAction& Action)
{
	if (!TileManager || Action.Changes.IsEmpty())
	{
		return false;
	}

	if (!UMapEditorActionStackLibrary::ApplyAction(TileManager, Action))
	{
		return false;
	}

	return CommitAppliedAction(Action);
}

bool UMapEditorActionStackContainerComponent::Undo(ATileManager* TileManager)
{
	if (!TileManager || UndoStack.IsEmpty())
	{
		return false;
	}

	const FMapEditAction Action = UndoStack.Pop();
	if (!UMapEditorActionStackLibrary::UndoAction(TileManager, Action))
	{
		UndoStack.Add(Action);
		return false;
	}

	RedoStack.Add(Action);
	return true;
}

bool UMapEditorActionStackContainerComponent::Redo(ATileManager* TileManager)
{
	if (!TileManager || RedoStack.IsEmpty())
	{
		return false;
	}

	const FMapEditAction Action = RedoStack.Pop();
	if (!UMapEditorActionStackLibrary::ApplyAction(TileManager, Action))
	{
		RedoStack.Add(Action);
		return false;
	}

	UndoStack.Add(Action);
	TrimUndoStack();
	return true;
}

void UMapEditorActionStackContainerComponent::ClearHistory()
{
	UndoStack.Empty();
	RedoStack.Empty();
}

bool UMapEditorActionStackContainerComponent::CanUndo() const
{
	return !UndoStack.IsEmpty();
}

bool UMapEditorActionStackContainerComponent::CanRedo() const
{
	return !RedoStack.IsEmpty();
}

FString UMapEditorActionStackContainerComponent::GetUndoLabel() const
{
	return UndoStack.IsEmpty() ? FString() : UndoStack.Last().Label;
}

FString UMapEditorActionStackContainerComponent::GetRedoLabel() const
{
	return RedoStack.IsEmpty() ? FString() : RedoStack.Last().Label;
}

void UMapEditorActionStackContainerComponent::TrimUndoStack()
{
	if (MaxUndoActions <= 0)
	{
		UndoStack.Empty();
		return;
	}

	while (UndoStack.Num() > MaxUndoActions)
	{
		UndoStack.RemoveAt(0);
	}
}
