// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CNmFloatSwitchNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nSwitchValueNodeIdx;
	int16 m_nTrueValueNodeIdx;
	int16 m_nFalseValueNodeIdx;
	float32 m_flFalseValue;
	float32 m_flTrueValue;
};
