// MGetKV3ClassDefaults = {
//	"_class": "CPlayerInputAnimMotorUpdater",
//	"m_name": "",
//	"m_bDefault": false,
//	"m_sampleTimes":
//	[
//	],
//	"m_flSpringConstant": 0.000000,
//	"m_flAnticipationDistance": 0.000000,
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
//	"m_bUseAcceleration": false
//}
class CPlayerInputAnimMotorUpdater : public CAnimMotorUpdaterBase
{
	CUtlVector< float32 > m_sampleTimes;
	float32 m_flSpringConstant;
	float32 m_flAnticipationDistance;
	CAnimParamHandle m_hAnticipationPosParam;
	CAnimParamHandle m_hAnticipationHeadingParam;
	bool m_bUseAcceleration;
};
