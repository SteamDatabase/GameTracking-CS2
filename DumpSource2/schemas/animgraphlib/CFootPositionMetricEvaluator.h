// MGetKV3ClassDefaults = {
//	"_class": "CFootPositionMetricEvaluator",
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
//	"m_bIgnoreSlope": false
//}
class CFootPositionMetricEvaluator : public CMotionMetricEvaluator
{
	CUtlVector< int32 > m_footIndices;
	bool m_bIgnoreSlope;
};
