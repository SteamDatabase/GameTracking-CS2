// MGetKV3ClassDefaults = {
//	"_class": "CVectorAnimParameter",
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
//		0.000000
//	],
//	"m_bInterpolate": false,
//	"m_vectorType": "ANIMPARAM_VECTOR_TYPE_NONE"
//}
// MPropertyFriendlyName = "Vector Parameter"
class CVectorAnimParameter : public CConcreteAnimParameter
{
	// MPropertyFriendlyName = "Default Value"
	Vector m_defaultValue;
	// MPropertyFriendlyName = "Interpolate"
	bool m_bInterpolate;
	// MPropertyFriendlyName = "Vector Type"
	AnimParamVectorType_t m_vectorType;
};
