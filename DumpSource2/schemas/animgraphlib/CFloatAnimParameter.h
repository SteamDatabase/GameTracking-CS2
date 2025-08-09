// M_LEGACY_OptInToSchemaPropertyDomain
// MGetKV3ClassDefaults = {
//	"_class": "CFloatAnimParameter",
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
//	"m_fDefaultValue": 0.000000,
//	"m_fMinValue": 0.000000,
//	"m_fMaxValue": 1.000000,
//	"m_bInterpolate": false
//}
// MPropertyFriendlyName = "Float Parameter"
class CFloatAnimParameter : public CConcreteAnimParameter
{
	// MPropertyFriendlyName = "Default Value"
	float32 m_fDefaultValue;
	// MPropertyFriendlyName = "Min Value"
	float32 m_fMinValue;
	// MPropertyFriendlyName = "Max Value"
	float32 m_fMaxValue;
	// MPropertyFriendlyName = "Interpolate"
	bool m_bInterpolate;
};
