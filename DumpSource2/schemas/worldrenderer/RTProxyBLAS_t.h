// MGetKV3ClassDefaults = {
//	"m_nFirstIndex": 0,
//	"m_nIndexCount": 0,
//	"m_nVBByteOffset": 0,
//	"m_nBaseVertex": 0,
//	"m_nVertexCount": 0,
//	"m_albedoFormat": "VERTEX_ALBEDO_NONE",
//	"m_boundLs":
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
//	"m_vVertexOriginLs":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vVertexExtentLs":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	]
//}
class RTProxyBLAS_t
{
	uint32 m_nFirstIndex;
	uint32 m_nIndexCount;
	uint32 m_nVBByteOffset;
	uint32 m_nBaseVertex;
	uint16 m_nVertexCount;
	VertexAlbedoFormat_t m_albedoFormat;
	AABB_t m_boundLs;
	Vector m_vVertexOriginLs;
	Vector m_vVertexExtentLs;
};
