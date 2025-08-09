// MGetKV3ClassDefaults = {
//	"_class": "CDampedPathAnimMotorUpdater",
//	"m_name": "",
//	"m_bDefault": false,
//	"m_bLockToPath": false,
//	"m_flAnticipationTime": 1.000000,
//	"m_flMinSpeedScale": 0.250000,
//	"m_hAnticipationPosParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_hAnticipationHeadingParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_flSpringConstant": 10.000000,
//	"m_flMinSpringTension": 1.000000,
//	"m_flMaxSpringTension": 100.000000
//}
class CDampedPathAnimMotorUpdater : public CPathAnimMotorUpdaterBase
{
	float32 m_flAnticipationTime;
	float32 m_flMinSpeedScale;
	CAnimParamHandle m_hAnticipationPosParam;
	CAnimParamHandle m_hAnticipationHeadingParam;
	float32 m_flSpringConstant;
	float32 m_flMinSpringTension;
	float32 m_flMaxSpringTension;
};
