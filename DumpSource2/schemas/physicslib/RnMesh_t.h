// MGetKV3ClassDefaults = {
//	"m_vMin":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vMax":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_Materials":
//	[
//	],
//	"m_vOrthographicAreas":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_nFlags": 0,
//	"m_nDebugFlags": 0,
//	"m_Nodes": "[BINARY BLOB]",
//	"m_Triangles": "[BINARY BLOB]",
//	"m_Vertices": "[BINARY BLOB]"
//}
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
