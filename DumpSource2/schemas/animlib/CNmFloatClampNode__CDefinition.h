class CNmFloatClampNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	Range_t m_clampRange;
};
