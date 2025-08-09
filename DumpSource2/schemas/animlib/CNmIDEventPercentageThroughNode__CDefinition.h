// MGetKV3ClassDefaults = {
//	"_class": "CNmIDEventPercentageThroughNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSourceStateNodeIdx": -1,
//	"m_eventConditionRules":
//	{
//		"m_flags": 0
//	},
//	"m_eventID": ""
//}
class CNmIDEventPercentageThroughNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	CNmBitFlags m_eventConditionRules;
	CGlobalSymbol m_eventID;
};
