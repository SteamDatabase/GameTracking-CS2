// MGetKV3ClassDefaults = {
//	"_class": "CIntAnimParameter",
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
//	"m_minValue": 0,
//	"m_maxValue": 100
//}
// MPropertyFriendlyName = "Int Parameter"
class CIntAnimParameter : public CConcreteAnimParameter
{
	// MPropertyFriendlyName = "Default Value"
	int32 m_defaultValue;
	// MPropertyFriendlyName = "Min Value"
	int32 m_minValue;
	// MPropertyFriendlyName = "Max Value"
	int32 m_maxValue;
};
