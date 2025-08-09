// MGetKV3ClassDefaults = {
//	"m_footInfo":
//	[
//	],
//	"m_flBlendTime": 0.000000,
//	"m_flLockBreakDistance": 0.000000,
//	"m_flMaxLegTwist": 25.000000,
//	"m_nHipBoneIndex": -1,
//	"m_bApplyLegTwistLimits": false,
//	"m_bApplyFootRotationLimits": false
//}
class FootPinningPoseOpFixedData_t
{
	CUtlVector< FootFixedData_t > m_footInfo;
	float32 m_flBlendTime;
	float32 m_flLockBreakDistance;
	float32 m_flMaxLegTwist;
	int32 m_nHipBoneIndex;
	bool m_bApplyLegTwistLimits;
	bool m_bApplyFootRotationLimits;
};
