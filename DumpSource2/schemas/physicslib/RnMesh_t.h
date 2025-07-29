// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class RnMesh_t
{
	Vector m_vMin;
	Vector m_vMax;
	CUtlVector< RnNode_t > m_Nodes;
	CUtlVectorSIMDPaddedVector m_Vertices;
	CUtlVector< RnTriangle_t > m_Triangles;
	CUtlVector< RnWing_t > m_Wings;
	CUtlVector< uint8 > m_TriangleEdgeFlags;
	CUtlVector< uint8 > m_Materials;
	Vector m_vOrthographicAreas;
	uint32 m_nFlags;
	uint32 m_nDebugFlags;
};
