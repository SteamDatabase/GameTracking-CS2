// MGetKV3ClassDefaults = {
//	"_class": "CNmBoneMaskSelectorNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_defaultMaskNodeIdx": -1,
//	"m_parameterValueNodeIdx": -1,
//	"m_bSwitchDynamically": false,
//	"m_maskNodeIndices":
//	[
//	],
//	"m_parameterValues":
//	[
//	],
//	"m_flBlendTimeSeconds": 0.100000
//}
class CNmBoneMaskSelectorNode::CDefinition : public CNmBoneMaskValueNode::CDefinition
{
	int16 m_defaultMaskNodeIdx;
	int16 m_parameterValueNodeIdx;
	bool m_bSwitchDynamically;
	CUtlVectorFixedGrowable< int16, 7 > m_maskNodeIndices;
	CUtlVectorFixedGrowable< CGlobalSymbol, 7 > m_parameterValues;
	float32 m_flBlendTimeSeconds;
};
