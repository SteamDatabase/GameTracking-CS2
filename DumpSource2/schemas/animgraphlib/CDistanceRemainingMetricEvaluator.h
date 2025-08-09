// MGetKV3ClassDefaults = {
//	"_class": "CDistanceRemainingMetricEvaluator",
//	"m_means":
//	[
//	],
//	"m_standardDeviations":
//	[
//	],
//	"m_flWeight": 0.000000,
//	"m_nDimensionStartIndex": -1,
//	"m_flMaxDistance": 0.000000,
//	"m_flMinDistance": 0.000000,
//	"m_flStartGoalFilterDistance": 0.000000,
//	"m_flMaxGoalOvershootScale": 0.000000,
//	"m_bFilterFixedMinDistance": false,
//	"m_bFilterGoalDistance": false,
//	"m_bFilterGoalOvershoot": false
//}
class CDistanceRemainingMetricEvaluator : public CMotionMetricEvaluator
{
	float32 m_flMaxDistance;
	float32 m_flMinDistance;
	float32 m_flStartGoalFilterDistance;
	float32 m_flMaxGoalOvershootScale;
	bool m_bFilterFixedMinDistance;
	bool m_bFilterGoalDistance;
	bool m_bFilterGoalOvershoot;
};
