class CNmIDEventNode::CDefinition : public CNmIDValueNode::CDefinition
{
	int16 m_nSourceStateNodeIdx;
	CNmBitFlags m_eventConditionRules;
	CGlobalSymbol m_defaultValue;
};
