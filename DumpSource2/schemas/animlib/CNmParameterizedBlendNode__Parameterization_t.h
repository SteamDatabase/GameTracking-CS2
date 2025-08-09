// MGetKV3ClassDefaults = {
//	"m_blendRanges":
//	[
//	],
//	"m_parameterRange":
//	{
//		"m_flMin": 340282346638528859811704183484516925440.000000,
//		"m_flMax": -340282346638528859811704183484516925440.000000
//	}
//}
class CNmParameterizedBlendNode::Parameterization_t
{
	CUtlLeanVectorFixedGrowable< CNmParameterizedBlendNode::BlendRange_t, 5 > m_blendRanges;
	Range_t m_parameterRange;
};
