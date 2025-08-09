// MGetKV3ClassDefaults = {
//	"m_ParticleBoneHash":
//	[
//	],
//	"m_Particles":
//	[
//	],
//	"m_Springs":
//	[
//	],
//	"m_Capsules":
//	[
//	],
//	"m_InitPose":
//	[
//	],
//	"m_ParticleBoneName":
//	[
//	]
//}
class PhysSoftbodyDesc_t
{
	CUtlVector< uint32 > m_ParticleBoneHash;
	CUtlVector< RnSoftbodyParticle_t > m_Particles;
	CUtlVector< RnSoftbodySpring_t > m_Springs;
	CUtlVector< RnSoftbodyCapsule_t > m_Capsules;
	CUtlVector< CTransform > m_InitPose;
	CUtlVector< CUtlString > m_ParticleBoneName;
};
