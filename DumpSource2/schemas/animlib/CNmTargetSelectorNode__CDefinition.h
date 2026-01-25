// MGetKV3ClassDefaults = {
//	"_class": "CNmTargetSelectorNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_optionNodeIndices":
//	[
//	],
//	"m_flOrientationScoreWeight": 1.000000,
//	"m_flPositionScoreWeight": 1.000000,
//	"m_parameterNodeIdx": -1,
//	"m_bIgnoreInvalidOptions": false,
//	"m_bIsWorldSpaceTarget": true
//}
class CNmTargetSelectorNode::CDefinition : public CNmClipReferenceNode::CDefinition
{
	CUtlLeanVectorFixedGrowable< int16, 5 > m_optionNodeIndices;
	float32 m_flOrientationScoreWeight;
	float32 m_flPositionScoreWeight;
	int16 m_parameterNodeIdx;
	bool m_bIgnoreInvalidOptions;
	bool m_bIsWorldSpaceTarget;
};
