// MGetKV3ClassDefaults = {
//	"m_traceSettings":
//	{
//		"m_flTraceHeight": 40.000000,
//		"m_flTraceRadius": 4.000000
//	},
//	"m_vFootBaseBindPosePositionMS":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flFootBaseLength": 0.000000,
//	"m_flMaxRotationLeft": 90.000000,
//	"m_flMaxRotationRight": 90.000000,
//	"m_footstepLandedTagIndex": -1,
//	"m_bEnableTracing": true,
//	"m_flTraceAngleBlend": 0.000000,
//	"m_nDisableTagIndex": -1,
//	"m_nFootIndex": -1
//}
class FootFixedSettings
{
	TraceSettings_t m_traceSettings;
	VectorAligned m_vFootBaseBindPosePositionMS;
	float32 m_flFootBaseLength;
	float32 m_flMaxRotationLeft;
	float32 m_flMaxRotationRight;
	int32 m_footstepLandedTagIndex;
	bool m_bEnableTracing;
	float32 m_flTraceAngleBlend;
	int32 m_nDisableTagIndex;
	int32 m_nFootIndex;
};
