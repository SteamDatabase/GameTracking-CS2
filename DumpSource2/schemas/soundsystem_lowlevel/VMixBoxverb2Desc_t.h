// MGetKV3ClassDefaults = {
//	"m_flSizeMax": 0.000000,
//	"m_flSizeMin": 0.000000,
//	"m_flComplexity": 0.000000,
//	"m_flDiffusion": 0.000000,
//	"m_flModDepth": 0.000000,
//	"m_flModRate": 0.000000,
//	"m_bParallel": false,
//	"m_filterType":
//	{
//		"m_nFilterType": "FILTER_UNKNOWN",
//		"m_nFilterSlope": "FILTER_SLOPE_12dB",
//		"m_bEnabled": true,
//		"m_fldbGain": 0.000000,
//		"m_flCutoffFreq": 1000.000000,
//		"m_flQ": 0.707107
//	},
//	"m_flWidth": 0.000000,
//	"m_flHeight": 0.000000,
//	"m_flDepth": 0.000000,
//	"m_flFeedbackScale": 0.000000,
//	"m_flFeedbackWidth": 0.000000,
//	"m_flFeedbackHeight": 0.000000,
//	"m_flFeedbackDepth": 0.000000,
//	"m_flOutputGain": 0.000000,
//	"m_flTaps": 0.000000
//}
class VMixBoxverb2Desc_t
{
	float32 m_flSizeMax;
	float32 m_flSizeMin;
	float32 m_flComplexity;
	float32 m_flDiffusion;
	float32 m_flModDepth;
	float32 m_flModRate;
	bool m_bParallel;
	VMixFilterDesc_t m_filterType;
	float32 m_flWidth;
	float32 m_flHeight;
	float32 m_flDepth;
	float32 m_flFeedbackScale;
	float32 m_flFeedbackWidth;
	float32 m_flFeedbackHeight;
	float32 m_flFeedbackDepth;
	float32 m_flOutputGain;
	float32 m_flTaps;
};
