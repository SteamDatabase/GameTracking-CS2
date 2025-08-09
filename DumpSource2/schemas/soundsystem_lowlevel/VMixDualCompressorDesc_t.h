// MGetKV3ClassDefaults = {
//	"m_flRMSTimeMS": 300.000000,
//	"m_fldbKneeWidth": 0.000000,
//	"m_flWetMix": 1.000000,
//	"m_bPeakMode": false,
//	"m_bandDesc":
//	{
//		"m_fldbGainInput": 0.000000,
//		"m_fldbGainOutput": 0.000000,
//		"m_fldbThresholdBelow": -40.000000,
//		"m_fldbThresholdAbove": -30.000000,
//		"m_flRatioBelow": 12.000000,
//		"m_flRatioAbove": 4.000000,
//		"m_flAttackTimeMS": 50.000000,
//		"m_flReleaseTimeMS": 200.000000,
//		"m_bEnable": false,
//		"m_bSolo": false
//	}
//}
class VMixDualCompressorDesc_t
{
	float32 m_flRMSTimeMS;
	float32 m_fldbKneeWidth;
	float32 m_flWetMix;
	bool m_bPeakMode;
	VMixDynamicsBand_t m_bandDesc;
};
