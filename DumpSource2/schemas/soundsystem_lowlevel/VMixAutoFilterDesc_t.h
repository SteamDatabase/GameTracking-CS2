// MGetKV3ClassDefaults = {
//	"m_flEnvelopeAmount": 0.000000,
//	"m_flAttackTimeMS": 5.000000,
//	"m_flReleaseTimeMS": 200.000000,
//	"m_filter":
//	{
//		"m_nFilterType": "FILTER_UNKNOWN",
//		"m_nFilterSlope": "FILTER_SLOPE_12dB",
//		"m_bEnabled": true,
//		"m_fldbGain": 0.000000,
//		"m_flCutoffFreq": 1000.000000,
//		"m_flQ": 0.707107
//	},
//	"m_flLFOAmount": 0.000000,
//	"m_flLFORate": 0.000000,
//	"m_flPhase": 0.000000,
//	"m_nLFOShape": "LFO_SHAPE_SINE"
//}
class VMixAutoFilterDesc_t
{
	float32 m_flEnvelopeAmount;
	float32 m_flAttackTimeMS;
	float32 m_flReleaseTimeMS;
	VMixFilterDesc_t m_filter;
	float32 m_flLFOAmount;
	float32 m_flLFORate;
	float32 m_flPhase;
	VMixLFOShape_t m_nLFOShape;
};
