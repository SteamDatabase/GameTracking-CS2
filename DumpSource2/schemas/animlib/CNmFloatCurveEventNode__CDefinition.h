// MGetKV3ClassDefaults = {
//	"_class": "CNmFloatCurveEventNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_eventID": "",
//	"m_nDefaultNodeIdx": -1,
//	"m_flDefaultValue": 0.000000,
//	"m_eventConditionRules":
//	{
//		"m_flags": 0
//	}
//}
class CNmFloatCurveEventNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	CGlobalSymbol m_eventID;
	int16 m_nDefaultNodeIdx;
	float32 m_flDefaultValue;
	CNmBitFlags m_eventConditionRules;
};
