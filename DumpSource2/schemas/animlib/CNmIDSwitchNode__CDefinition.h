// MGetKV3ClassDefaults = {
//	"_class": "CNmIDSwitchNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nSwitchValueNodeIdx": -1,
//	"m_nTrueValueNodeIdx": -1,
//	"m_nFalseValueNodeIdx": -1,
//	"m_falseValue": "",
//	"m_trueValue": ""
//}
class CNmIDSwitchNode::CDefinition : public CNmIDValueNode::CDefinition
{
	int16 m_nSwitchValueNodeIdx;
	int16 m_nTrueValueNodeIdx;
	int16 m_nFalseValueNodeIdx;
	CGlobalSymbol m_falseValue;
	CGlobalSymbol m_trueValue;
};
