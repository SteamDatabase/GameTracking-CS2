class CNmClipNode::CDefinition : public CNmPoseNode::CDefinition
{
	int16 m_nPlayInReverseValueNodeIdx;
	int16 m_nResetTimeValueNodeIdx;
	bool m_bSampleRootMotion;
	bool m_bAllowLooping;
	int16 m_nDataSlotIdx;
};
