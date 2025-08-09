// MGetKV3ClassDefaults = {
//	"m_Name": "",
//	"m_IsPublic": true,
//	"m_ValueType": "PVAL_VEC3",
//	"m_DefaultConfig":
//	{
//		"m_ConfigName": "",
//		"m_ConfigValue": null,
//		"m_iAttachType": "PATTACH_INVALID",
//		"m_BoundEntityPath": "",
//		"m_strEntityScope": "",
//		"m_strAttachmentName": ""
//	},
//	"m_NamedConfigs":
//	[
//	]
//}
class ParticleNamedValueSource_t
{
	CUtlString m_Name;
	bool m_IsPublic;
	// MPropertySuppressField
	PulseValueType_t m_ValueType;
	// MPropertySuppressField
	ParticleNamedValueConfiguration_t m_DefaultConfig;
	// MPropertySuppressField
	CUtlVector< ParticleNamedValueConfiguration_t > m_NamedConfigs;
};
