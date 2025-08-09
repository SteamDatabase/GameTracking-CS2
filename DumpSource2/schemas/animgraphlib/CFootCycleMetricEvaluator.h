// MGetKV3ClassDefaults = {
//	"_class": "CFootCycleMetricEvaluator",
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
//	]
//}
class CFootCycleMetricEvaluator : public CMotionMetricEvaluator
{
	CUtlVector< int32 > m_footIndices;
};
