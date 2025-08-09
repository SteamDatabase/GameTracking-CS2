// MGetKV3ClassDefaults = {
//	"_class": "CNmParameterizedClipSelectorNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_optionNodeIndices":
//	[
//	],
//	"m_optionWeights":
//	[
//	],
//	"m_parameterNodeIdx": 0,
//	"m_bIgnoreInvalidOptions": false,
//	"m_bHasWeightsSet": false
//}
class CNmParameterizedClipSelectorNode::CDefinition : public CNmClipReferenceNode::CDefinition
{
	CUtlLeanVectorFixedGrowable< int16, 5 > m_optionNodeIndices;
	CUtlLeanVectorFixedGrowable< uint8, 5 > m_optionWeights;
	int16 m_parameterNodeIdx;
	bool m_bIgnoreInvalidOptions;
	bool m_bHasWeightsSet;
};
