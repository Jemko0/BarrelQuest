---@meta

--- NOTE: In this file, underscores (_) in names represent spaces from Blueprint.
--- For example: 'Apply_Damage' in Lua corresponds to 'Apply Damage' in Blueprint.
--- Access these using bracket notation: object["Apply Damage"]

---@diagnostic disable: undefined-doc-name
---@class MeshDescriptionBase
---Mesh Description Base
---
--- Properties
local MeshDescriptionBase = {}

--- Methods
---Sets a vertex position
---@param VertexID VertexID
---@return nil
function MeshDescriptionBase.SetVertexPosition(VertexID) end

---Set the vertex instance at the given index around the polygon to the new value
---@param PolygonID PolygonID
---@return nil
function MeshDescriptionBase.SetPolygonVertexInstances(PolygonID) end

---Sets the polygon group associated with a polygon
---@param PolygonID PolygonID
---@param PolygonGroupID PolygonGroupID
---@return nil
function MeshDescriptionBase.SetPolygonPolygonGroup(PolygonID, PolygonGroupID) end

---Reverse the winding order of the vertices of this polygon
---@param PolygonID PolygonID
---@return nil
function MeshDescriptionBase.ReversePolygonFacing(PolygonID) end

---Reserves space for this number of new vertices
---@param NumberOfNewVertices integer
---@return nil
function MeshDescriptionBase.ReserveNewVertices(NumberOfNewVertices) end

---Reserves space for this number of new vertex instances
---@param NumberOfNewVertexInstances integer
---@return nil
function MeshDescriptionBase.ReserveNewVertexInstances(NumberOfNewVertexInstances) end

---Reserves space for this number of new triangles
---@param NumberOfNewTriangles integer
---@return nil
function MeshDescriptionBase.ReserveNewTriangles(NumberOfNewTriangles) end

---Reserves space for this number of new polygons
---@param NumberOfNewPolygons integer
---@return nil
function MeshDescriptionBase.ReserveNewPolygons(NumberOfNewPolygons) end

---Reserves space for this number of new polygon groups
---@param NumberOfNewPolygonGroups integer
---@return nil
function MeshDescriptionBase.ReserveNewPolygonGroups(NumberOfNewPolygonGroups) end

---Reserves space for this number of new edges
---@param NumberOfNewEdges integer
---@return nil
function MeshDescriptionBase.ReserveNewEdges(NumberOfNewEdges) end

---Returns whether the passed vertex ID is valid
---@param VertexID VertexID
---@return boolean
function MeshDescriptionBase.IsVertexValid(VertexID) end

---Returns whether a given vertex is orphaned, i.e. it doesn't form part of any polygon
---@param VertexID VertexID
---@return boolean
function MeshDescriptionBase.IsVertexOrphaned(VertexID) end

---Returns whether the passed vertex instance ID is valid
---@param VertexInstanceID VertexInstanceID
---@return boolean
function MeshDescriptionBase.IsVertexInstanceValid(VertexInstanceID) end

---Returns whether the passed triangle ID is valid
---@param TriangleID TriangleID
---@return boolean
function MeshDescriptionBase.IsTriangleValid(TriangleID) end

---Determines if this triangle is part of an n-gon
---@param TriangleID TriangleID
---@return boolean
function MeshDescriptionBase.IsTrianglePartOfNgon(TriangleID) end

---Returns whether the passed polygon ID is valid
---@param PolygonID PolygonID
---@return boolean
function MeshDescriptionBase.IsPolygonValid(PolygonID) end

---Returns whether the passed polygon group ID is valid
---@param PolygonGroupID PolygonGroupID
---@return boolean
function MeshDescriptionBase.IsPolygonGroupValid(PolygonGroupID) end

---Return whether the mesh description is empty
---@return boolean
function MeshDescriptionBase.IsEmpty() end

---Returns whether the passed edge ID is valid
---@param EdgeID EdgeID
---@return boolean
function MeshDescriptionBase.IsEdgeValid(EdgeID) end

---Determine whether a given edge is an internal edge between triangles of a specific polygon
---@param EdgeID EdgeID
---@param PolygonID PolygonID
---@return boolean
function MeshDescriptionBase.IsEdgeInternalToPolygon(EdgeID, PolygonID) end

---Determine whether a given edge is an internal edge between triangles of a polygon
---@param EdgeID EdgeID
---@return boolean
function MeshDescriptionBase.IsEdgeInternal(EdgeID) end

---Returns reference to an array of VertexInstance IDs instanced from this vertex
---@param VertexID VertexID
---@return nil, VertexInstanceID[]
function MeshDescriptionBase.GetVertexVertexInstances(VertexID) end

---Gets a vertex position
---@param VertexID VertexID
---@return Vector
function MeshDescriptionBase.GetVertexPosition(VertexID) end

---Returns the edge ID defined by the two given vertex IDs, if there is one; otherwise INDEX_NONE
---@param VertexID0 VertexID
---@param VertexID1 VertexID
---@return EdgeID
function MeshDescriptionBase.GetVertexPairEdge(VertexID0, VertexID1) end

---Returns the vertex ID associated with the given vertex instance
---@param VertexInstanceID VertexInstanceID
---@return VertexID
function MeshDescriptionBase.GetVertexInstanceVertex(VertexInstanceID) end

---Returns the edge ID defined by the two given vertex instance IDs, if there is one; otherwise INDEX_NONE
---@param VertexInstanceID0 VertexInstanceID
---@param VertexInstanceID1 VertexInstanceID
---@return EdgeID
function MeshDescriptionBase.GetVertexInstancePairEdge(VertexInstanceID0, VertexInstanceID1) end

---Return the vertex instance which corresponds to the given vertex on the given triangle, or INDEX_NONE
---@param TriangleID TriangleID
---@param VertexID VertexID
---@return VertexInstanceID
function MeshDescriptionBase.GetVertexInstanceForTriangleVertex(TriangleID, VertexID) end

---Return the vertex instance which corresponds to the given vertex on the given polygon, or INDEX_NONE
---@param PolygonID PolygonID
---@param VertexID VertexID
---@return VertexInstanceID
function MeshDescriptionBase.GetVertexInstanceForPolygonVertex(PolygonID, VertexID) end

---Returns the number of vertex instances
---@return integer
function MeshDescriptionBase.GetVertexInstanceCount() end

---Returns reference to an array of Triangle IDs connected to this vertex instance
---@param VertexInstanceID VertexInstanceID
---@return nil, TriangleID[]
function MeshDescriptionBase.GetVertexInstanceConnectedTriangles(VertexInstanceID) end

---Returns the polygons connected to this vertex instance
---@param VertexInstanceID VertexInstanceID
---@return nil, PolygonID[]
function MeshDescriptionBase.GetVertexInstanceConnectedPolygons(VertexInstanceID) end

---Returns the number of vertices
---@return integer
function MeshDescriptionBase.GetVertexCount() end

---Returns the triangles connected to this vertex
---@param VertexID VertexID
---@return nil, TriangleID[]
function MeshDescriptionBase.GetVertexConnectedTriangles(VertexID) end

---Returns the polygons connected to this vertex
---@param VertexID VertexID
---@return nil, PolygonID[]
function MeshDescriptionBase.GetVertexConnectedPolygons(VertexID) end

---Returns reference to an array of Edge IDs connected to this vertex
---@param VertexID VertexID
---@return nil, EdgeID[]
function MeshDescriptionBase.GetVertexConnectedEdges(VertexID) end

---Returns the vertices adjacent to this vertex
---@param VertexID VertexID
---@return nil, VertexID[]
function MeshDescriptionBase.GetVertexAdjacentVertices(VertexID) end

---Returns the vertices which define this triangle
---@param TriangleID TriangleID
---@return nil, VertexID[]
function MeshDescriptionBase.GetTriangleVertices(TriangleID) end

---Get the vertex instances which define this triangle
---@param TriangleID TriangleID
---@return nil, VertexInstanceID[]
function MeshDescriptionBase.GetTriangleVertexInstances(TriangleID) end

---Get the specified vertex instance by index
---@param TriangleID TriangleID
---@param Index integer
---@return VertexInstanceID
function MeshDescriptionBase.GetTriangleVertexInstance(TriangleID, Index) end

---Get the polygon group which contains this triangle
---@param TriangleID TriangleID
---@return PolygonGroupID
function MeshDescriptionBase.GetTrianglePolygonGroup(TriangleID) end

---Get the polygon which contains this triangle
---@param TriangleID TriangleID
---@return PolygonID
function MeshDescriptionBase.GetTrianglePolygon(TriangleID) end

---Returns the edges which define this triangle
---@param TriangleID TriangleID
---@return nil, EdgeID[]
function MeshDescriptionBase.GetTriangleEdges(TriangleID) end

---Returns the number of triangles
---@return integer
function MeshDescriptionBase.GetTriangleCount() end

---Returns the adjacent triangles to this triangle
---@param TriangleID TriangleID
---@return nil, TriangleID[]
function MeshDescriptionBase.GetTriangleAdjacentTriangles(TriangleID) end

---Returns the vertices which form the polygon perimeter
---@param PolygonID PolygonID
---@return nil, VertexID[]
function MeshDescriptionBase.GetPolygonVertices(PolygonID) end

---Returns reference to an array of VertexInstance IDs forming the perimeter of this polygon
---@param PolygonID PolygonID
---@return nil, VertexInstanceID[]
function MeshDescriptionBase.GetPolygonVertexInstances(PolygonID) end

---Return reference to an array of triangle IDs which comprise this polygon
---@param PolygonID PolygonID
---@return nil, TriangleID[]
function MeshDescriptionBase.GetPolygonTriangles(PolygonID) end

---Return the polygon group associated with a polygon
---@param PolygonID PolygonID
---@return PolygonGroupID
function MeshDescriptionBase.GetPolygonPolygonGroup(PolygonID) end

---Returns the edges which form the polygon perimeter
---@param PolygonID PolygonID
---@return nil, EdgeID[]
function MeshDescriptionBase.GetPolygonPerimeterEdges(PolygonID) end

---Populate the provided array with a list of edges which are internal to the polygon, i.e. those which separate
---          constituent triangles.
---@param PolygonID PolygonID
---@return nil, EdgeID[]
function MeshDescriptionBase.GetPolygonInternalEdges(PolygonID) end

---Returns the polygons associated with the given polygon group
---@param PolygonGroupID PolygonGroupID
---@return nil, PolygonID[]
function MeshDescriptionBase.GetPolygonGroupPolygons(PolygonGroupID) end

---Returns the number of polygon groups
---@return integer
function MeshDescriptionBase.GetPolygonGroupCount() end

---Returns the number of polygons
---@return integer
function MeshDescriptionBase.GetPolygonCount() end

---Populates the passed array with adjacent polygons
---@param PolygonID PolygonID
---@return nil, PolygonID[]
function MeshDescriptionBase.GetPolygonAdjacentPolygons(PolygonID) end

---Returns number of vertex instances created from this vertex
---@param VertexID VertexID
---@return integer
function MeshDescriptionBase.GetNumVertexVertexInstances(VertexID) end

---Returns the number of triangles connected to this vertex instance
---@param VertexInstanceID VertexInstanceID
---@return integer
function MeshDescriptionBase.GetNumVertexInstanceConnectedTriangles(VertexInstanceID) end

---Returns the number of polygons connected to this vertex instance.
---@param VertexInstanceID VertexInstanceID
---@return integer
function MeshDescriptionBase.GetNumVertexInstanceConnectedPolygons(VertexInstanceID) end

---Returns number of triangles connected to this vertex
---@param VertexID VertexID
---@return integer
function MeshDescriptionBase.GetNumVertexConnectedTriangles(VertexID) end

---Returns the number of polygons connected to this vertex
---@param VertexID VertexID
---@return integer
function MeshDescriptionBase.GetNumVertexConnectedPolygons(VertexID) end

---Returns number of edges connected to this vertex
---@param VertexID VertexID
---@return integer
function MeshDescriptionBase.GetNumVertexConnectedEdges(VertexID) end

---Returns the number of vertices this polygon has
---@param PolygonID PolygonID
---@return integer
function MeshDescriptionBase.GetNumPolygonVertices(PolygonID) end

---Return the number of triangles which comprise this polygon
---@param PolygonID PolygonID
---@return integer
function MeshDescriptionBase.GetNumPolygonTriangles(PolygonID) end

---Return the number of internal edges in this polygon
---@param PolygonID PolygonID
---@return integer
function MeshDescriptionBase.GetNumPolygonInternalEdges(PolygonID) end

---Returns the number of polygons in this polygon group
---@param PolygonGroupID PolygonGroupID
---@return integer
function MeshDescriptionBase.GetNumPolygonGroupPolygons(PolygonGroupID) end

---Returns the number of triangles connected to this edge
---@param EdgeID EdgeID
---@return integer
function MeshDescriptionBase.GetNumEdgeConnectedTriangles(EdgeID) end

---Returns the number of polygons connected to this edge
---@param EdgeID EdgeID
---@return integer
function MeshDescriptionBase.GetNumEdgeConnectedPolygons(EdgeID) end

---Returns a pair of vertex IDs defining the edge
---@param EdgeID EdgeID
---@return nil, VertexID[]
function MeshDescriptionBase.GetEdgeVertices(EdgeID) end

---Returns the vertex ID corresponding to one of the edge endpoints
---@param EdgeID EdgeID
---@param VertexNumber integer
---@return VertexID
function MeshDescriptionBase.GetEdgeVertex(EdgeID, VertexNumber) end

---Returns the number of edges
---@return integer
function MeshDescriptionBase.GetEdgeCount() end

---Returns reference to an array of triangle IDs connected to this edge
---@param EdgeID EdgeID
---@return nil, TriangleID[]
function MeshDescriptionBase.GetEdgeConnectedTriangles(EdgeID) end

---Returns the polygons connected to this edge
---@param EdgeID EdgeID
---@return nil, PolygonID[]
function MeshDescriptionBase.GetEdgeConnectedPolygons(EdgeID) end

---Empty the mesh description
---@return nil
function MeshDescriptionBase.Empty() end

---Deletes a vertex instance from a mesh
---@param VertexInstanceID VertexInstanceID
---@return nil, VertexID[]
function MeshDescriptionBase.DeleteVertexInstance(VertexInstanceID) end

---Deletes a vertex from the mesh
---@param VertexID VertexID
---@return nil
function MeshDescriptionBase.DeleteVertex(VertexID) end

---Deletes a triangle from the mesh
---@param TriangleID TriangleID
---@return nil, EdgeID[], VertexInstanceID[], PolygonGroupID[]
function MeshDescriptionBase.DeleteTriangle(TriangleID) end

---Deletes a polygon group from the mesh
---@param PolygonGroupID PolygonGroupID
---@return nil
function MeshDescriptionBase.DeletePolygonGroup(PolygonGroupID) end

---Deletes a polygon from the mesh
---@param PolygonID PolygonID
---@return nil, EdgeID[], VertexInstanceID[], PolygonGroupID[]
function MeshDescriptionBase.DeletePolygon(PolygonID) end

---Deletes an edge from a mesh
---@param EdgeID EdgeID
---@return nil, VertexID[]
function MeshDescriptionBase.DeleteEdge(EdgeID) end

---Adds a new vertex to the mesh with the given ID
---@param VertexID VertexID
---@return nil
function MeshDescriptionBase.CreateVertexWithID(VertexID) end

---Adds a new vertex instance to the mesh with the given ID
---@param VertexInstanceID VertexInstanceID
---@param VertexID VertexID
---@return nil
function MeshDescriptionBase.CreateVertexInstanceWithID(VertexInstanceID, VertexID) end

---Adds a new vertex instance to the mesh and returns its ID
---@param VertexID VertexID
---@return VertexInstanceID
function MeshDescriptionBase.CreateVertexInstance(VertexID) end

---Adds a new vertex to the mesh and returns its ID
---@return VertexID
function MeshDescriptionBase.CreateVertex() end

---Adds a new triangle to the mesh with the given ID. This will also make an encapsulating polygon, and any missing edges.
---@param TriangleID TriangleID
---@param PolygonGroupID PolygonGroupID
---@return nil, EdgeID[]
function MeshDescriptionBase.CreateTriangleWithID(TriangleID, PolygonGroupID) end

---Adds a new triangle to the mesh and returns its ID. This will also make an encapsulating polygon, and any missing edges.
---@param PolygonGroupID PolygonGroupID
---@return TriangleID
function MeshDescriptionBase.CreateTriangle(PolygonGroupID) end

---Adds a new polygon to the mesh with the given ID. This will also make any missing edges, and all constituent triangles.
---@param PolygonID PolygonID
---@param PolygonGroupID PolygonGroupID
---@return nil, VertexInstanceID[], EdgeID[]
function MeshDescriptionBase.CreatePolygonWithID(PolygonID, PolygonGroupID) end

---Adds a new polygon group to the mesh with the given ID
---@param PolygonGroupID PolygonGroupID
---@return nil
function MeshDescriptionBase.CreatePolygonGroupWithID(PolygonGroupID) end

---Adds a new polygon group to the mesh and returns its ID
---@return PolygonGroupID
function MeshDescriptionBase.CreatePolygonGroup() end

---Adds a new polygon to the mesh and returns its ID. This will also make any missing edges, and all constituent triangles.
---@param PolygonGroupID PolygonGroupID
---@return PolygonID
function MeshDescriptionBase.CreatePolygon(PolygonGroupID) end

---Adds a new edge to the mesh with the given ID
---@param EdgeID EdgeID
---@param VertexID0 VertexID
---@param VertexID1 VertexID
---@return nil
function MeshDescriptionBase.CreateEdgeWithID(EdgeID, VertexID0, VertexID1) end

---Adds a new edge to the mesh and returns its ID
---@param VertexID0 VertexID
---@param VertexID1 VertexID
---@return EdgeID
function MeshDescriptionBase.CreateEdge(VertexID0, VertexID1) end

---Generates triangles and internal edges for the given polygon
---@param PolygonID PolygonID
---@return nil
function MeshDescriptionBase.ComputePolygonTriangulation(PolygonID) end

return MeshDescriptionBase
