class CNmFloatRemapNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	CNmFloatRemapNode::RemapRange_t m_inputRange;
	CNmFloatRemapNode::RemapRange_t m_outputRange;
};
