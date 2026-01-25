// MGetKV3ClassDefaults = {
//	"m_nFlags": "",
//	"m_albedoFormat": "VERTEX_ALBEDO_NONE",
//	"m_nBLASCount": 0,
//	"m_nBLASIndex": 0,
//	"m_nVertexAlbedoByteOffset": 0,
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
//	]
//}
class RTProxyInstanceInfo_t
{
	RTProxyInstanceFlags_t m_nFlags;
	VertexAlbedoFormat_t m_albedoFormat;
	uint16 m_nBLASCount;
	uint32 m_nBLASIndex;
	uint32 m_nVertexAlbedoByteOffset;
	matrix3x4_t m_mWorldFromLocal;
};
