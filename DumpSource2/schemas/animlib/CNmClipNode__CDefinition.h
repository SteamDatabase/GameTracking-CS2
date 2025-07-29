// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmClipNode::CDefinition : public CNmClipReferenceNode::CDefinition
{
	int16 m_nPlayInReverseValueNodeIdx;
	int16 m_nResetTimeValueNodeIdx;
	float32 m_flSpeedMultiplier;
	int32 m_nStartSyncEventOffset;
	bool m_bSampleRootMotion;
	bool m_bAllowLooping;
	int16 m_nDataSlotIdx;
};
