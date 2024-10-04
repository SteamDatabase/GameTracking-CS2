class CNmParameterizedBlendNode::Parameterization_t
{
	CUtlLeanVectorFixedGrowable< CNmParameterizedBlendNode::BlendRange_t, 5 > m_blendRanges;
	Range_t m_parameterRange;
};
