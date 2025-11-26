---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class ViewConeActor : Actor
---An actor that generates a procedural mesh representing a cone of vision.
---It uses asynchronous line traces to detect obstacles and builds the mesh based on hit results.
---
--- Properties
---Number of traces to process per asynchronous task.
---@field TracesPerThread integer
---The maximum distance of the vision cone.
---@field VisionRange number
---The total horizontal angle of the vision cone in degrees.
---@field VisionAngle number
---The angular separation in degrees between each trace. Smaller values mean more traces and a denser mesh.
---@field AngleStep number
---If enabled, draws debug lines and spheres for each trace.
---@field bDebugDraw boolean
---The material to apply to the generated vision mesh.
---@field VisionMaterial MaterialInterface
---The procedural mesh component that will render the vision cone.
---@field VisionMesh ProceduralMeshComponent
---@field TraceChannel integer
local ViewConeActor = {}

--- Methods
return ViewConeActor
