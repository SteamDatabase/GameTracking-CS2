// MGetKV3ClassDefaults = {
//	"_class": "CNmFollowBoneNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nChildNodeIdx": -1,
//	"m_bone": "",
//	"m_followTargetBone": "",
//	"m_nEnabledNodeIdx": -1,
//	"m_mode": "RotationAndTranslation"
//}
class CNmFollowBoneNode::CDefinition : public CNmPassthroughNode::CDefinition
{
	CGlobalSymbol m_bone;
	CGlobalSymbol m_followTargetBone;
	int16 m_nEnabledNodeIdx;
	NmFollowBoneMode_t m_mode;
};
