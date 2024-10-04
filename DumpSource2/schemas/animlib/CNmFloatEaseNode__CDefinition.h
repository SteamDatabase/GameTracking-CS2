class CNmFloatEaseNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	float32 m_flEaseTime;
	float32 m_flStartValue;
	int16 m_nInputValueNodeIdx;
	NmEasingOperation_t m_easingOp;
	bool m_bUseStartValue;
}
