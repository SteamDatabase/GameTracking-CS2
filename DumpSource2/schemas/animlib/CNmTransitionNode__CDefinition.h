// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
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
