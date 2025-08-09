// MGetKV3ClassDefaults = {
//	"_class": "CNmTransitionEventConditionNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_requireRuleID": "",
//	"m_eventConditionRules":
//	{
//		"m_flags": 0
//	},
//	"m_nSourceStateNodeIdx": -1,
//	"m_ruleCondition": "AnyAllowed"
//}
class CNmTransitionEventConditionNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	CGlobalSymbol m_requireRuleID;
	CNmBitFlags m_eventConditionRules;
	int16 m_nSourceStateNodeIdx;
	NmTransitionRuleCondition_t m_ruleCondition;
};
