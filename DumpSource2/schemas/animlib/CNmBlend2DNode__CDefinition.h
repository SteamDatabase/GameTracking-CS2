class CNmBlend2DNode::CDefinition : public CNmPoseNode::CDefinition
{
	CUtlVectorFixedGrowable< int16, 5 > m_sourceNodeIndices;
	int16 m_nInputParameterNodeIdx0;
	int16 m_nInputParameterNodeIdx1;
	CUtlVectorFixedGrowable< Vector2D, 10 > m_values;
	CUtlVectorFixedGrowable< uint8, 30 > m_indices;
	CUtlVectorFixedGrowable< uint8, 10 > m_hullIndices;
	bool m_bAllowLooping;
};
