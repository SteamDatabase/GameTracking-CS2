// MGetKV3ClassDefaults = {
//	"_class": "CNmBlend2DNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_sourceNodeIndices":
//	[
//	],
//	"m_nInputParameterNodeIdx0": -1,
//	"m_nInputParameterNodeIdx1": -1,
//	"m_values":
//	[
//	],
//	"m_indices":
//	[
//	],
//	"m_hullIndices":
//	[
//	],
//	"m_bAllowLooping": true
//}
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
