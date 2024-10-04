class CNmFloatMathNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdxA;
	int16 m_nInputValueNodeIdxB;
	bool m_bReturnAbsoluteResult;
	CNmFloatMathNode::Operator_t m_operator;
	float32 m_flValueB;
}
