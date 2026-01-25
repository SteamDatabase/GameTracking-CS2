// MGetKV3ClassDefaults = {
//	"_class": "CVMixFilterProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_nFilterType": "FILTER_UNKNOWN",
//		"m_nFilterSlope": "FILTER_SLOPE_12dB",
//		"m_bEnabled": true,
//		"m_fldbGain": 0.000000,
//		"m_flCutoffFreq": 1000.000000,
//		"m_flQ": 0.707107
//	}
//}
class CVMixFilterProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixFilterDesc_t m_desc;
};
