// MGetKV3ClassDefaults = {
//	"_class": "CLookComponentUpdater",
//	"m_name": "",
//	"m_id":
//	{
//		"m_id": 4294967295
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_bStartEnabled": false,
//	"m_hLookHeading":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hLookHeadingNormalized":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hLookHeadingVelocity":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hLookPitch":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hLookDistance":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hLookDirection":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hLookTarget":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hLookTargetWorldSpace":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_bNetworkLookTarget": true
//}
class CLookComponentUpdater : public CAnimComponentUpdater
{
	CAnimParamHandle m_hLookHeading;
	CAnimParamHandle m_hLookHeadingNormalized;
	CAnimParamHandle m_hLookHeadingVelocity;
	CAnimParamHandle m_hLookPitch;
	CAnimParamHandle m_hLookDistance;
	CAnimParamHandle m_hLookDirection;
	CAnimParamHandle m_hLookTarget;
	CAnimParamHandle m_hLookTargetWorldSpace;
	bool m_bNetworkLookTarget;
};
