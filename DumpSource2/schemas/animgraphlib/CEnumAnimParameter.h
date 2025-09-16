// MGetKV3ClassDefaults = {
//	"_class": "CEnumAnimParameter",
//	"m_name": "Unnamed Parameter",
//	"m_sComment": "",
//	"m_group": "",
//	"m_id":
//	{
//		"m_id": 4294967295
//	},
//	"m_componentName": "",
//	"m_bNetworkingRequested": false,
//	"m_bIsReferenced": false,
//	"m_previewButton": "ANIMPARAM_BUTTON_NONE",
//	"m_eNetworkSetting": "Auto",
//	"m_bUseMostRecentValue": false,
//	"m_bAutoReset": false,
//	"m_bGameWritable": true,
//	"m_bGraphWritable": false,
//	"m_defaultValue": 0,
//	"m_enumOptions":
//	[
//	],
//	"m_vecEnumReferenced":
//	[
//	]
//}
// MPropertyFriendlyName = "Enum Parameter"
class CEnumAnimParameter : public CConcreteAnimParameter
{
	// MPropertyFriendlyName = "Default Value"
	uint8 m_defaultValue;
	// MPropertyFriendlyName = "Values"
	CUtlVector< CUtlString > m_enumOptions;
	// MPropertySuppressField
	CUtlVector< uint64 > m_vecEnumReferenced;
};
