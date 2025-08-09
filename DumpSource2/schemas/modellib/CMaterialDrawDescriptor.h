// MGetKV3ClassDefaults = {
//	"m_flUvDensity": 0.000000,
//	"m_vTintColor":
//	[
//		1.000000,
//		1.000000,
//		1.000000
//	],
//	"m_flAlpha": 1.000000,
//	"m_nNumMeshlets": 0,
//	"m_nFirstMeshlet": 0,
//	"m_nAppliedIndexOffset": 0,
//	"m_nDepthVertexBufferIndex": 255,
//	"m_nMeshletPackedIVBIndex": 255,
//	"m_rigidMeshParts":
//	[
//	],
//	"m_nPrimitiveType": "RENDER_PRIM_TRIANGLES",
//	"m_nBaseVertex": 0,
//	"m_nVertexCount": 0,
//	"m_nStartIndex": 0,
//	"m_nIndexCount": 0,
//	"m_indexBuffer":
//	{
//		"m_hBuffer": 0,
//		"m_nBindOffsetBytes": 0
//	},
//	"m_meshletPackedIVB":
//	{
//		"m_hBuffer": 0,
//		"m_nBindOffsetBytes": 0
//	},
//	"m_material": "",
//	"m_vertexBuffers":
//	[
//	]
//}
class CMaterialDrawDescriptor
{
	float32 m_flUvDensity;
	Vector m_vTintColor;
	float32 m_flAlpha;
	uint16 m_nNumMeshlets;
	uint32 m_nFirstMeshlet;
	uint32 m_nAppliedIndexOffset;
	uint8 m_nDepthVertexBufferIndex;
	uint8 m_nMeshletPackedIVBIndex;
	CUtlLeanVector< CMaterialDrawDescriptor::RigidMeshPart_t > m_rigidMeshParts;
	RenderPrimitiveType_t m_nPrimitiveType;
	int32 m_nBaseVertex;
	int32 m_nVertexCount;
	int32 m_nStartIndex;
	int32 m_nIndexCount;
	CRenderBufferBinding m_indexBuffer;
	CRenderBufferBinding m_meshletPackedIVB;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_material;
};
