// MGetKV3ClassDefaults = {
//	"_class": "CNmTransitionNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nTargetStateNodeIdx": -1,
//	"m_nDurationOverrideNodeIdx": -1,
//	"m_syncEventOffsetOverrideNodeIdx": -1,
//	"m_startBoneMaskNodeIdx": -1,
//	"m_flDuration": 0.000000,
//	"m_boneMaskBlendInTimePercentage":
//	{
//		"m_flValue": 0.330000
//	},
//	"m_syncEventOffset": 0.000000,
//	"m_transitionOptions":
//	{
//		"m_flags": 1
//	},
//	"m_targetSyncIDNodeIdx": -1,
//	"m_blendWeightEasing": "Linear",
//	"m_rootMotionBlend": "Blend"
//}
class CNmTransitionNode::CDefinition : public CNmPoseNode::CDefinition
{
	int16 m_nTargetStateNodeIdx;
	int16 m_nDurationOverrideNodeIdx;
	int16 m_syncEventOffsetOverrideNodeIdx;
	int16 m_startBoneMaskNodeIdx;
	float32 m_flDuration;
	NmPercent_t m_boneMaskBlendInTimePercentage;
	float32 m_syncEventOffset;
	CNmBitFlags m_transitionOptions;
	int16 m_targetSyncIDNodeIdx;
	NmEasingOperation_t m_blendWeightEasing;
	NmRootMotionBlendMode_t m_rootMotionBlend;
};
