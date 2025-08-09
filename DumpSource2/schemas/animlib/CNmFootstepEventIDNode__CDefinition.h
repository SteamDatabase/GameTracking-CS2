// MGetKV3ClassDefaults = {
//	"_class": "CNmFootstepEventIDNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSourceStateNodeIdx": -1,
//	"m_eventConditionRules":
//	{
//		"m_flags": 0
//	}
//}
class CNmFootstepEventIDNode::CDefinition : public CNmIDValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	CNmBitFlags m_eventConditionRules;
};
