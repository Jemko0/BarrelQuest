---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MovieSceneSequence : MovieSceneSignedObject
---Abstract base class for movie scene animations (C++ version).
---
--- Properties
---The default completion mode for this movie scene when a section's completion mode is set to project default
---@field DefaultCompletionMode EMovieSceneCompletionMode
---true if the result of GetParentObject is significant in object resolution for LocateBoundObjects.
---When true, if GetParentObject returns nullptr, the PlaybackContext will be used for LocateBoundObjects, other wise the object's parent will be used
---When false, the PlaybackContext will always be used for LocateBoundObjects
---@field bParentContextsAreSignificant boolean
---When true, this sequence should be compiled as if it is playable directly (outside of a root sequence). When false, various compiled data will be omitted, preventing direct playback at runtime (although will still play as a sub sequence)
---@field bPlayableDirectly boolean
---Flags used to define this sequence's behavior and characteristics
---@field SequenceFlags EMovieSceneSequenceFlags
local MovieSceneSequence = {}

--- Methods
---Get the earliest timecode source out of all of the movie scene sections contained within this sequence's movie scene.
---@return MovieSceneTimecodeSource
function MovieSceneSequence.GetEarliestTimecodeSource() end

---Find all object binding IDs associated with the specified tag name (set up through RMB->Expose on Object bindings from within sequencer)
---@param InBindingName string
---@return MovieSceneObjectBindingID[]
function MovieSceneSequence.FindBindingsByTag(InBindingName) end

---Find the first object binding ID associated with the specified tag name (set up through RMB->Expose on Object bindings from within sequencer)
---@param InBindingName string
---@return MovieSceneObjectBindingID
function MovieSceneSequence.FindBindingByTag(InBindingName) end

return MovieSceneSequence
