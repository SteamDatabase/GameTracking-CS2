// MGetKV3ClassDefaults = {
//	"_class": "CVMixDelayProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_feedbackFilter":
//		{
//			"m_nFilterType": "FILTER_UNKNOWN",
//			"m_nFilterSlope": "FILTER_SLOPE_12dB",
//			"m_bEnabled": true,
//			"m_fldbGain": 0.000000,
//			"m_flCutoffFreq": 1000.000000,
//			"m_flQ": 0.707107
//		},
//		"m_bEnableFilter": false,
//		"m_flDelay": 0.000000,
//		"m_flDirectGain": 0.000000,
//		"m_flDelayGain": 0.000000,
//		"m_flFeedbackGain": 0.000000,
//		"m_flWidth": 0.000000
//	}
//}
class CVMixDelayProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixDelayDesc_t m_desc;
};
