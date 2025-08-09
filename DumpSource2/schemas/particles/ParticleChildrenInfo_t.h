// MGetKV3ClassDefaults = {
//	"m_ChildRef": "",
//	"m_flDelay": 0.000000,
//	"m_bEndCap": false,
//	"m_bDisableChild": false,
//	"m_nDetailLevel": "PARTICLEDETAIL_LOW"
//}
class ParticleChildrenInfo_t
{
	// MPropertySuppressField
	CStrongHandle< InfoForResourceTypeIParticleSystemDefinition > m_ChildRef;
	// MPropertyFriendlyName = "delay"
	float32 m_flDelay;
	// MPropertyFriendlyName = "end cap effect"
	bool m_bEndCap;
	// MPropertySuppressField
	bool m_bDisableChild;
	// MPropertyFriendlyName = "disable at detail levels below"
	ParticleDetailLevel_t m_nDetailLevel;
};
