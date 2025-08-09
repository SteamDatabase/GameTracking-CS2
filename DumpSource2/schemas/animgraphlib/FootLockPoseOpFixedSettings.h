// MGetKV3ClassDefaults = {
//	"m_footInfo":
//	[
//	],
//	"m_hipDampingSettings":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_nHipBoneIndex": -1,
//	"m_ikSolverType": "IKSOLVER_TwoBone",
//	"m_bApplyTilt": false,
//	"m_bApplyHipDrop": false,
//	"m_bAlwaysUseFallbackHinge": false,
//	"m_bApplyFootRotationLimits": false,
//	"m_bApplyLegTwistLimits": false,
//	"m_flMaxFootHeight": -12.000000,
//	"m_flExtensionScale": 0.700000,
//	"m_flMaxLegTwist": 180.000000,
//	"m_bEnableLockBreaking": false,
//	"m_flLockBreakTolerance": 0.200000,
//	"m_flLockBlendTime": 0.200000,
//	"m_bEnableStretching": false,
//	"m_flMaxStretchAmount": 2.000000,
//	"m_flStretchExtensionScale": 0.998000
//}
class FootLockPoseOpFixedSettings
{
	CUtlVector< FootFixedData_t > m_footInfo;
	CAnimInputDamping m_hipDampingSettings;
	int32 m_nHipBoneIndex;
	IKSolverType m_ikSolverType;
	bool m_bApplyTilt;
	bool m_bApplyHipDrop;
	bool m_bAlwaysUseFallbackHinge;
	bool m_bApplyFootRotationLimits;
	bool m_bApplyLegTwistLimits;
	float32 m_flMaxFootHeight;
	float32 m_flExtensionScale;
	float32 m_flMaxLegTwist;
	bool m_bEnableLockBreaking;
	float32 m_flLockBreakTolerance;
	float32 m_flLockBlendTime;
	bool m_bEnableStretching;
	float32 m_flMaxStretchAmount;
	float32 m_flStretchExtensionScale;
};
