---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name

---@diagnostic disable: redundant-parameter

---@class StaticMeshSocket
---Static Mesh Socket
---
--- Properties
---
---Defines a named attachment location on the UStaticMesh.
---These are set up in editor and used as a shortcut instead of specifying
---everything explicitly to AttachComponent in the StaticMeshComponent.
---The Outer of a StaticMeshSocket should always be the UStaticMesh.
---@field SocketName string
---@field RelativeLocation Vector
---@field RelativeRotation Rotator
---@field RelativeScale Vector
---@field Tag string
---@field PreviewStaticMesh StaticMesh
---Whether the socket was imported with the asset or created in the editor. Importer will remove/modify only imported socket and will not touch any editor created socket.
---@field bSocketCreatedAtImport boolean
local StaticMeshSocket = {}

--- Methods
return StaticMeshSocket
