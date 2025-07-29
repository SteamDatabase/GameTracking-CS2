// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmFollowBoneNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	CGlobalSymbol m_bone;
	CGlobalSymbol m_followTargetBone;
	int16 m_nEnabledNodeIdx;
	NmFollowBoneMode_t m_mode;
};
