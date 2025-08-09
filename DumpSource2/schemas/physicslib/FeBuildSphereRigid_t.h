// MGetKV3ClassDefaults = {
//	"vSphere":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"nNode": 0,
//	"nCollisionMask": 65535,
//	"nVertexMapIndex": 65535,
//	"nFlags": 0,
//	"m_nPriority": 0,
//	"m_nVertexMapHash": 0,
//	"m_nAntitunnelGroupBits": 0
//}
class FeBuildSphereRigid_t : public FeSphereRigid_t
{
	int32 m_nPriority;
	uint32 m_nVertexMapHash;
	uint32 m_nAntitunnelGroupBits;
};
