// MGetKV3ClassDefaults = {
//	"_class": "CFutureVelocityMetricEvaluator",
//	"m_means":
//	[
//	],
//	"m_standardDeviations":
//	[
//	],
//	"m_flWeight": 0.000000,
//	"m_nDimensionStartIndex": -1,
//	"m_flDistance": 0.000000,
//	"m_flStoppingDistance": 0.000000,
//	"m_flTargetSpeed": 0.000000,
//	"m_eMode": "DirectionOnly"
//}
class CFutureVelocityMetricEvaluator : public CMotionMetricEvaluator
{
	float32 m_flDistance;
	float32 m_flStoppingDistance;
	float32 m_flTargetSpeed;
	VelocityMetricMode m_eMode;
};
