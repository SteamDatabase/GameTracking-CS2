// MGetKV3ClassDefaults = {
//	"_class": "CMotionMatchingUpdateNode",
//	"m_nodePath":
//	{
//		"m_path":
//		[
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			}
//		],
//		"m_nCount": 0
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_name": "",
//	"m_dataSet":
//	{
//		"m_groups":
//		[
//		],
//		"m_nDimensionCount": 0
//	},
//	"m_metrics":
//	[
//	],
//	"m_weights":
//	[
//	],
//	"m_bSearchEveryTick": false,
//	"m_flSearchInterval": 0.100000,
//	"m_bSearchWhenClipEnds": true,
//	"m_bSearchWhenGoalChanges": true,
//	"m_blendCurve":
//	{
//		"m_flControlPoint1": 0.000000,
//		"m_flControlPoint2": 1.000000
//	},
//	"m_flSampleRate": 0.100000,
//	"m_flBlendTime": 0.300000,
//	"m_bLockClipWhenWaning": false,
//	"m_flSelectionThreshold": 0.000000,
//	"m_flReselectionTimeWindow": 0.300000,
//	"m_bEnableRotationCorrection": true,
//	"m_bGoalAssist": false,
//	"m_flGoalAssistDistance": 0.000000,
//	"m_flGoalAssistTolerance": 0.000000,
//	"m_distanceScale_Damping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_flDistanceScale_OuterRadius": 0.000000,
//	"m_flDistanceScale_InnerRadius": 0.000000,
//	"m_flDistanceScale_MaxScale": 0.000000,
//	"m_flDistanceScale_MinScale": 0.000000,
//	"m_bEnableDistanceScaling": false
//}
class CMotionMatchingUpdateNode : public CLeafUpdateNode
{
	CMotionDataSet m_dataSet;
	CUtlVector< CSmartPtr< CMotionMetricEvaluator > > m_metrics;
	CUtlVector< float32 > m_weights;
	bool m_bSearchEveryTick;
	float32 m_flSearchInterval;
	bool m_bSearchWhenClipEnds;
	bool m_bSearchWhenGoalChanges;
	CBlendCurve m_blendCurve;
	float32 m_flSampleRate;
	float32 m_flBlendTime;
	bool m_bLockClipWhenWaning;
	float32 m_flSelectionThreshold;
	float32 m_flReselectionTimeWindow;
	bool m_bEnableRotationCorrection;
	bool m_bGoalAssist;
	float32 m_flGoalAssistDistance;
	float32 m_flGoalAssistTolerance;
	CAnimInputDamping m_distanceScale_Damping;
	float32 m_flDistanceScale_OuterRadius;
	float32 m_flDistanceScale_InnerRadius;
	float32 m_flDistanceScale_MaxScale;
	float32 m_flDistanceScale_MinScale;
	bool m_bEnableDistanceScaling;
};
