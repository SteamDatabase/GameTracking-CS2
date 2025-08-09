// MGetKV3ClassDefaults = {
//	"_class": "CPathMetricEvaluator",
//	"m_means":
//	[
//	],
//	"m_standardDeviations":
//	[
//	],
//	"m_flWeight": 0.000000,
//	"m_nDimensionStartIndex": -1,
//	"m_pathTimeSamples":
//	[
//	],
//	"m_flDistance": 0.000000,
//	"m_bExtrapolateMovement": false,
//	"m_flMinExtrapolationSpeed": 0.000000
//}
class CPathMetricEvaluator : public CMotionMetricEvaluator
{
	CUtlVector< float32 > m_pathTimeSamples;
	float32 m_flDistance;
	bool m_bExtrapolateMovement;
	float32 m_flMinExtrapolationSpeed;
};
