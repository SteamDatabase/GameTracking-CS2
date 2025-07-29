// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmChainLookatNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	CGlobalSymbol m_chainEndBoneID;
	int16 m_nLookatTargetNodeIdx;
	int16 m_nEnabledNodeIdx;
	float32 m_flBlendTimeSeconds;
	uint8 m_nChainLength;
	bool m_bIsTargetInWorldSpace;
	Vector m_chainForwardDir;
};
