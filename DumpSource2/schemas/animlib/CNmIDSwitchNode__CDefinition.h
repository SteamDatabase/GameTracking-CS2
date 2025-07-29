// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmIDSwitchNode::CDefinition : public CNmIDValueNode::CDefinition
{
	int16 m_nSwitchValueNodeIdx;
	int16 m_nTrueValueNodeIdx;
	int16 m_nFalseValueNodeIdx;
	CGlobalSymbol m_falseValue;
	CGlobalSymbol m_trueValue;
};
