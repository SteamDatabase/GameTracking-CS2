// MGetKV3ClassDefaults = {
//	"m_nFilterType": "FILTER_UNKNOWN",
//	"m_nFilterSlope": "FILTER_SLOPE_12dB",
//	"m_bEnabled": true,
//	"m_fldbGain": 0.000000,
//	"m_flCutoffFreq": 1000.000000,
//	"m_flQ": 0.707107
//}
class VMixFilterDesc_t
{
	VMixFilterType_t m_nFilterType;
	VMixFilterSlope_t m_nFilterSlope;
	bool m_bEnabled;
	float32 m_fldbGain;
	float32 m_flCutoffFreq;
	float32 m_flQ;
};
