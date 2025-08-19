// MGetKV3ClassDefaults = {
//	"_class": "CFootLockUpdateNode",
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
//	"m_pChildNode":
//	{
//		"m_nodeIndex": -1
//	},
//	"m_opFixedSettings":
//	{
//		"m_footInfo":
//		[
//		],
//		"m_hipDampingSettings":
//		{
//			"_class": "CAnimInputDamping",
//			"m_speedFunction": "NoDamping",
//			"m_fSpeedScale": 1.000000,
//			"m_fFallingSpeedScale": 1.000000
//		},
//		"m_nHipBoneIndex": -1,
//		"m_ikSolverType": "IKSOLVER_TwoBone",
//		"m_bApplyTilt": false,
//		"m_bApplyHipDrop": false,
//		"m_bAlwaysUseFallbackHinge": false,
//		"m_bApplyFootRotationLimits": false,
//		"m_bApplyLegTwistLimits": false,
//		"m_flMaxFootHeight": -12.000000,
//		"m_flExtensionScale": 0.700000,
//		"m_flMaxLegTwist": 180.000000,
//		"m_bEnableLockBreaking": false,
//		"m_flLockBreakTolerance": 0.200000,
//		"m_flLockBlendTime": 0.200000,
//		"m_bEnableStretching": false,
//		"m_flMaxStretchAmount": 2.000000,
//		"m_flStretchExtensionScale": 0.998000
//	},
//	"m_footSettings":
//	[
//	],
//	"m_hipShiftDamping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_rootHeightDamping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_flStrideCurveScale": 0.000000,
//	"m_flStrideCurveLimitScale": 0.000000,
//	"m_flStepHeightIncreaseScale": 0.000000,
//	"m_flStepHeightDecreaseScale": 0.000000,
//	"m_flHipShiftScale": 0.000000,
//	"m_flBlendTime": 0.000000,
//	"m_flMaxRootHeightOffset": 0.000000,
//	"m_flMinRootHeightOffset": 0.000000,
//	"m_flTiltPlanePitchSpringStrength": <HIDDEN FOR DIFF>,
//	"m_flTiltPlaneRollSpringStrength": <HIDDEN FOR DIFF>,
//	"m_bApplyFootRotationLimits": false,
//	"m_bApplyHipShift": false,
//	"m_bModulateStepHeight": false,
//	"m_bResetChild": false,
//	"m_bEnableVerticalCurvedPaths": false,
//	"m_bEnableRootHeightDamping": false
//}
class CFootLockUpdateNode : public CUnaryUpdateNode
{
	FootLockPoseOpFixedSettings m_opFixedSettings;
	CUtlVector< FootFixedSettings > m_footSettings;
	CAnimInputDamping m_hipShiftDamping;
	CAnimInputDamping m_rootHeightDamping;
	float32 m_flStrideCurveScale;
	float32 m_flStrideCurveLimitScale;
	float32 m_flStepHeightIncreaseScale;
	float32 m_flStepHeightDecreaseScale;
	float32 m_flHipShiftScale;
	float32 m_flBlendTime;
	float32 m_flMaxRootHeightOffset;
	float32 m_flMinRootHeightOffset;
	float32 m_flTiltPlanePitchSpringStrength;
	float32 m_flTiltPlaneRollSpringStrength;
	bool m_bApplyFootRotationLimits;
	bool m_bApplyHipShift;
	bool m_bModulateStepHeight;
	bool m_bResetChild;
	bool m_bEnableVerticalCurvedPaths;
	bool m_bEnableRootHeightDamping;
};
