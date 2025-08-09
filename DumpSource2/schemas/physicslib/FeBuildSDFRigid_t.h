// MGetKV3ClassDefaults = {
//	"vLocalMin":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"vLocalMax":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"flBounciness": 0.000000,
//	"nNode": 0,
//	"nCollisionMask": 65535,
//	"nVertexMapIndex": 65535,
//	"nFlags": 0,
//	"m_Distances":
//	[
//	],
//	"m_nWidth": 8,
//	"m_nHeight": 8,
//	"m_nDepth": 8,
//	"m_nPriority": 0,
//	"m_nVertexMapHash": 0,
//	"m_nAntitunnelGroupBits": 0
//}
class FeBuildSDFRigid_t : public FeSDFRigid_t
{
	int32 m_nPriority;
	uint32 m_nVertexMapHash;
	uint32 m_nAntitunnelGroupBits;
};
