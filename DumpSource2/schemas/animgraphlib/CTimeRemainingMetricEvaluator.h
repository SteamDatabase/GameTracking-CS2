// MGetKV3ClassDefaults = {
//	"_class": "CTimeRemainingMetricEvaluator",
//	"m_means":
//	[
//	],
//	"m_standardDeviations":
//	[
//	],
//	"m_flWeight": 0.000000,
//	"m_nDimensionStartIndex": -1,
//	"m_bMatchByTimeRemaining": false,
//	"m_flMaxTimeRemaining": 0.000000,
//	"m_bFilterByTimeRemaining": false,
//	"m_flMinTimeRemaining": 0.000000
//}
class CTimeRemainingMetricEvaluator : public CMotionMetricEvaluator
{
	bool m_bMatchByTimeRemaining;
	float32 m_flMaxTimeRemaining;
	bool m_bFilterByTimeRemaining;
	float32 m_flMinTimeRemaining;
};
