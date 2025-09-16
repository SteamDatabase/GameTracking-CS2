// MGetKV3ClassDefaults = {
//	"_class": "CQuaternionAnimParameter",
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
//	"m_defaultValue":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_bInterpolate": false
//}
// MPropertyFriendlyName = "Quaternion Parameter"
class CQuaternionAnimParameter : public CConcreteAnimParameter
{
	// MPropertySuppressField
	Quaternion m_defaultValue;
	// MPropertyFriendlyName = "Interpolate"
	bool m_bInterpolate;
};
