// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmTwoBoneIKNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	CGlobalSymbol m_effectorBoneID;
	int16 m_nEffectorTargetNodeIdx;
	int16 m_nEnabledNodeIdx;
	float32 m_flBlendTimeSeconds;
	NmIKBlendMode_t m_blendMode;
	bool m_bIsTargetInWorldSpace;
};
