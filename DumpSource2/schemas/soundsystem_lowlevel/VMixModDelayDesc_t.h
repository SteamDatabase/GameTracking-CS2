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
//	"m_bPhaseInvert": true,
//	"m_flGlideTime": 0.000000,
//	"m_flDelay": <HIDDEN FOR DIFF>,
//	"m_flOutputGain": 0.000000,
//	"m_flFeedbackGain": 0.000000,
//	"m_flModRate": 0.000000,
//	"m_flModDepth": 0.000000,
//	"m_bApplyAntialiasing": false
//}
class VMixModDelayDesc_t
{
	VMixFilterDesc_t m_feedbackFilter;
	bool m_bPhaseInvert;
	float32 m_flGlideTime;
	float32 m_flDelay;
	float32 m_flOutputGain;
	float32 m_flFeedbackGain;
	float32 m_flModRate;
	float32 m_flModDepth;
	bool m_bApplyAntialiasing;
};
