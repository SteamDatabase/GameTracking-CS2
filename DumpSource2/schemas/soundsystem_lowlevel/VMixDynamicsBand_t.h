// MGetKV3ClassDefaults = {
//	"m_fldbGainInput": 0.000000,
//	"m_fldbGainOutput": 0.000000,
//	"m_fldbThresholdBelow": -40.000000,
//	"m_fldbThresholdAbove": -30.000000,
//	"m_flRatioBelow": 12.000000,
//	"m_flRatioAbove": 4.000000,
//	"m_flAttackTimeMS": 50.000000,
//	"m_flReleaseTimeMS": 200.000000,
//	"m_bEnable": false,
//	"m_bSolo": false
//}
class VMixDynamicsBand_t
{
	// MPropertyFriendlyName = "Input Gain (dB)"
	float32 m_fldbGainInput;
	// MPropertyFriendlyName = "Output Gain (dB)"
	float32 m_fldbGainOutput;
	// MPropertyFriendlyName = "Below Threshold(dB)"
	float32 m_fldbThresholdBelow;
	// MPropertyFriendlyName = "Above Threshold(dB)"
	float32 m_fldbThresholdAbove;
	// MPropertyFriendlyName = "Upward Ratio"
	float32 m_flRatioBelow;
	// MPropertyFriendlyName = "Downward Ratio"
	float32 m_flRatioAbove;
	// MPropertyFriendlyName = "Attack time (ms)"
	float32 m_flAttackTimeMS;
	// MPropertyFriendlyName = "Release time (ms)"
	float32 m_flReleaseTimeMS;
	// MPropertyFriendlyName = "Enabled"
	bool m_bEnable;
	// MPropertyFriendlyName = "Solo"
	bool m_bSolo;
};
