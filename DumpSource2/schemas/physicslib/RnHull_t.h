// MGetKV3ClassDefaults = {
//	"m_vCentroid":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flMaxAngularRadius": 0.000000,
//	"m_Bounds":
//	{
//		"m_vMinBounds":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_vMaxBounds":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		]
//	},
//	"m_vOrthographicAreas":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_MassProperties":
//	[
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000
//	],
//	"m_flVolume": 0.000000,
//	"m_flSurfaceArea": 0.000000,
//	"m_nFlags": 0,
//	"m_pRegionSVM": null,
//	"m_Vertices": "[BINARY BLOB]",
//	"m_VertexPositions": "[BINARY BLOB]",
//	"m_Edges": "[BINARY BLOB]",
//	"m_Faces": "[BINARY BLOB]",
//	"m_Planes": "[BINARY BLOB]"
//}
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
