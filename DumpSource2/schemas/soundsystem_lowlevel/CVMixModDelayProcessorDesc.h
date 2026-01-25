// MGetKV3ClassDefaults = {
//	"_class": "CVMixModDelayProcessorDesc",
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
//		"m_bPhaseInvert": false,
//		"m_flGlideTime": 0.000000,
//		"m_flDelay": 0.000000,
//		"m_flOutputGain": 0.000000,
//		"m_flFeedbackGain": 0.000000,
//		"m_flModRate": 0.000000,
//		"m_flModDepth": 0.000000,
//		"m_bApplyAntialiasing": false
//	}
//}
class CVMixModDelayProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixModDelayDesc_t m_desc;
};
