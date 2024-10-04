class CNmAnimationPoseNode::CDefinition : public CNmPoseNode::CDefinition
{
	int16 m_nPoseTimeValueNodeIdx;
	int16 m_nDataSlotIdx;
	Range_t m_inputTimeRemapRange;
	float32 m_flUserSpecifiedTime;
	bool m_bUseFramesAsInput;
}
