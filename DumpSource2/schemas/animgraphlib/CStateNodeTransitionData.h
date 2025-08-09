// MGetKV3ClassDefaults = {
//	"m_curve":
//	{
//		"m_flControlPoint1": 0.000000,
//		"m_flControlPoint2": 1.000000
//	},
//	"m_blendDuration":
//	{
//		"m_constValue": 0.000000,
//		"m_hParam":
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		}
//	},
//	"m_resetCycleValue":
//	{
//		"m_constValue": 0.000000,
//		"m_hParam":
//		{
//			"m_type": "ANIMPARAM_UNKNOWN",
//			"m_index": 255
//		}
//	},
//	"m_bReset": 0,
//	"m_resetCycleOption": 0
//}
class CStateNodeTransitionData
{
	CBlendCurve m_curve;
	CAnimValue< float32 > m_blendDuration;
	CAnimValue< float32 > m_resetCycleValue;
	bitfield:1 m_bReset;
	bitfield:3 m_resetCycleOption;
};
