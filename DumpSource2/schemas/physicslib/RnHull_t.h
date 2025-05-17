// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class RnHull_t
{
	Vector m_vCentroid;
	float32 m_flMaxAngularRadius;
	AABB_t m_Bounds;
	Vector m_vOrthographicAreas;
	matrix3x4_t m_MassProperties;
	float32 m_flVolume;
	float32 m_flSurfaceArea;
	CUtlVector< RnVertex_t > m_Vertices;
	CUtlVector< Vector > m_VertexPositions;
	CUtlVector< RnHalfEdge_t > m_Edges;
	CUtlVector< RnFace_t > m_Faces;
	CUtlVector< RnPlane_t > m_FacePlanes;
	uint32 m_nFlags;
	CRegionSVM* m_pRegionSVM;
};
