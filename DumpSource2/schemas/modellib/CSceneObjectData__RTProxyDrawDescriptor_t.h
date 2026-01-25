// MGetKV3ClassDefaults = {
//	"m_drawDesc":
//	{
//		"m_flUvDensity": 0.000000,
//		"m_vTintColor":
//		[
//			1.000000,
//			1.000000,
//			1.000000
//		],
//		"m_flAlpha": 1.000000,
//		"m_nNumMeshlets": 0,
//		"m_nFirstMeshlet": 0,
//		"m_nAppliedIndexOffset": 0,
//		"m_nDepthVertexBufferIndex": 255,
//		"m_nMeshletPackedIVBIndex": 255,
//		"m_rigidMeshParts":
//		[
//		],
//		"m_nPrimitiveType": "RENDER_PRIM_TRIANGLES",
//		"m_nBaseVertex": 0,
//		"m_nVertexCount": 0,
//		"m_nStartIndex": 0,
//		"m_nIndexCount": 0,
//		"m_indexBuffer":
//		{
//			"m_hBuffer": 0,
//			"m_nBindOffsetBytes": 0
//		},
//		"m_meshletPackedIVB":
//		{
//			"m_hBuffer": 0,
//			"m_nBindOffsetBytes": 0
//		},
//		"m_material": "",
//		"m_vertexBuffers":
//		[
//		]
//	},
//	"m_mWorldFromLocal":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_nVertexAlbedoFormat": "VERTEX_ALBEDO_NONE",
//	"m_nVertexAlbedoVB": -1,
//	"m_nVertexAlbedoOffset": 0,
//	"m_nVertexAlbedoStride": 0
//}
class CSceneObjectData::RTProxyDrawDescriptor_t
{
	CMaterialDrawDescriptor m_drawDesc;
	matrix3x4_t m_mWorldFromLocal;
	VertexAlbedoFormat_t m_nVertexAlbedoFormat;
	int8 m_nVertexAlbedoVB;
	uint16 m_nVertexAlbedoOffset;
	uint16 m_nVertexAlbedoStride;
};
