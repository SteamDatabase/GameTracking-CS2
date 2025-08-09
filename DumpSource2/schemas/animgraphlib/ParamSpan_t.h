// MGetKV3ClassDefaults = {
//	"m_samples":
//	[
//	],
//	"m_hParam":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_eParamType": "ANIMPARAM_UNKNOWN",
//	"m_flStartCycle": 0.000000,
//	"m_flEndCycle": 0.000000
//}
class ParamSpan_t
{
	CUtlVector< ParamSpanSample_t > m_samples;
	CAnimParamHandle m_hParam;
	AnimParamType_t m_eParamType;
	float32 m_flStartCycle;
	float32 m_flEndCycle;
};
