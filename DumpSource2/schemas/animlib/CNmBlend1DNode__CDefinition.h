// MGetKV3ClassDefaults = {
//	"_class": "CNmBlend1DNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_sourceNodeIndices":
//	[
//	],
//	"m_nInputParameterValueNodeIdx": -1,
//	"m_bAllowLooping": true,
//	"m_parameterization":
//	{
//		"m_blendRanges":
//		[
//		],
//		"m_parameterRange":
//		{
//			"m_flMin": 340282346638528859811704183484516925440.000000,
//			"m_flMax": -340282346638528859811704183484516925440.000000
//		}
//	}
//}
class CNmBlend1DNode::CDefinition : public CNmParameterizedBlendNode::CDefinition
{
	CNmParameterizedBlendNode::Parameterization_t m_parameterization;
};
