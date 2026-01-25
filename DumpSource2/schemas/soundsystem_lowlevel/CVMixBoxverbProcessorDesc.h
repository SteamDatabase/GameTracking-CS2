// MGetKV3ClassDefaults = {
//	"_class": "CVMixBoxverbProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_flSizeMax": 0.000000,
//		"m_flSizeMin": 0.000000,
//		"m_flComplexity": 0.000000,
//		"m_flDiffusion": 0.000000,
//		"m_flModDepth": 0.000000,
//		"m_flModRate": 0.000000,
//		"m_bParallel": false,
//		"m_filterType":
//		{
//			"m_nFilterType": "FILTER_UNKNOWN",
//			"m_nFilterSlope": "FILTER_SLOPE_12dB",
//			"m_bEnabled": true,
//			"m_fldbGain": 0.000000,
//			"m_flCutoffFreq": 1000.000000,
//			"m_flQ": 0.707107
//		},
//		"m_flWidth": 0.000000,
//		"m_flHeight": 0.000000,
//		"m_flDepth": 0.000000,
//		"m_flFeedbackScale": 0.000000,
//		"m_flFeedbackWidth": 0.000000,
//		"m_flFeedbackHeight": 0.000000,
//		"m_flFeedbackDepth": 0.000000,
//		"m_flOutputGain": 0.000000,
//		"m_flTaps": 0.000000
//	}
//}
class CVMixBoxverbProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixBoxverbDesc_t m_desc;
};
