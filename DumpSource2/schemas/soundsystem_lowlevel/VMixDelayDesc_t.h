// MGetKV3ClassDefaults = {
//	"m_feedbackFilter":
//	{
//		"m_nFilterType": "FILTER_UNKNOWN",
//		"m_nFilterSlope": "FILTER_SLOPE_12dB",
//		"m_bEnabled": true,
//		"m_fldbGain": 0.000000,
//		"m_flCutoffFreq": 1000.000000,
//		"m_flQ": 0.707107
//	},
//	"m_bEnableFilter": false,
//	"m_flDelay": 0.000000,
//	"m_flDirectGain": 0.000000,
//	"m_flDelayGain": 0.000000,
//	"m_flFeedbackGain": 0.000000,
//	"m_flWidth": 0.000000
//}
class VMixDelayDesc_t
{
	VMixFilterDesc_t m_feedbackFilter;
	bool m_bEnableFilter;
	float32 m_flDelay;
	float32 m_flDirectGain;
	float32 m_flDelayGain;
	float32 m_flFeedbackGain;
	float32 m_flWidth;
};
