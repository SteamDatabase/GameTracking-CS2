// MGetKV3ClassDefaults = {
//	"_class": "CStepsRemainingMetricEvaluator",
//	"m_means":
//	[
//	],
//	"m_standardDeviations":
//	[
//	],
//	"m_flWeight": 0.000000,
//	"m_nDimensionStartIndex": -1,
//	"m_footIndices":
//	[
//	],
//	"m_flMinStepsRemaining": 0.000000
//}
class CStepsRemainingMetricEvaluator : public CMotionMetricEvaluator
{
	CUtlVector< int32 > m_footIndices;
	float32 m_flMinStepsRemaining;
};
