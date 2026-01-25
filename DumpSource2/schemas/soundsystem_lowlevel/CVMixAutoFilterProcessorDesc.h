// MGetKV3ClassDefaults = {
//	"_class": "CVMixAutoFilterProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_flEnvelopeAmount": 0.000000,
//		"m_flAttackTimeMS": 5.000000,
//		"m_flReleaseTimeMS": 200.000000,
//		"m_filter":
//		{
//			"m_nFilterType": "FILTER_UNKNOWN",
//			"m_nFilterSlope": "FILTER_SLOPE_12dB",
//			"m_bEnabled": true,
//			"m_fldbGain": 0.000000,
//			"m_flCutoffFreq": 1000.000000,
//			"m_flQ": 0.707107
//		},
//		"m_flLFOAmount": 0.000000,
//		"m_flLFORate": 0.000000,
//		"m_flPhase": 0.000000,
//		"m_nLFOShape": "LFO_SHAPE_SINE"
//	}
//}
class CVMixAutoFilterProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixAutoFilterDesc_t m_desc;
};
