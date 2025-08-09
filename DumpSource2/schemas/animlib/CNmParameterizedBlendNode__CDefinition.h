// MGetKV3ClassDefaults = {
//	"_class": "CNmParameterizedBlendNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_sourceNodeIndices":
//	[
//	],
//	"m_nInputParameterValueNodeIdx": -1,
//	"m_bAllowLooping": true
//}
class CNmParameterizedBlendNode::CDefinition : public CNmPoseNode::CDefinition
{
	CUtlVectorFixedGrowable< int16, 5 > m_sourceNodeIndices;
	int16 m_nInputParameterValueNodeIdx;
	bool m_bAllowLooping;
};
