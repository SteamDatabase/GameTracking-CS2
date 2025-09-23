// MGetKV3ClassDefaults = {
//	"m_fldbGainOutput": -0.000000,
//	"m_flRMSTimeMS": 0.000000,
//	"m_fldbKneeWidth": <HIDDEN FOR DIFF>,
//	"m_flDepth": 0.000000,
//	"m_flWetMix": 0.000000,
//	"m_flTimeScale": 0.000000,
//	"m_flLowCutoffFreq": <HIDDEN FOR DIFF>,
//	"m_flHighCutoffFreq": 0.000000,
//	"m_bPeakMode": true,
//	"m_bandDesc":
//	[
//		{
//			"m_fldbGainInput": 0.000000,
//			"m_fldbGainOutput": 0.000000,
//			"m_fldbThresholdBelow": -40.000000,
//			"m_fldbThresholdAbove": -30.000000,
//			"m_flRatioBelow": 12.000000,
//			"m_flRatioAbove": 4.000000,
//			"m_flAttackTimeMS": 50.000000,
//			"m_flReleaseTimeMS": 200.000000,
//			"m_bEnable": false,
//			"m_bSolo": false
//		},
//		{
//			"m_fldbGainInput": 0.000000,
//			"m_fldbGainOutput": 0.000000,
//			"m_fldbThresholdBelow": -40.000000,
//			"m_fldbThresholdAbove": -30.000000,
//			"m_flRatioBelow": 12.000000,
//			"m_flRatioAbove": 4.000000,
//			"m_flAttackTimeMS": 50.000000,
//			"m_flReleaseTimeMS": 200.000000,
//			"m_bEnable": false,
//			"m_bSolo": false
//		},
//		{
//			"m_fldbGainInput": 0.000000,
//			"m_fldbGainOutput": 0.000000,
//			"m_fldbThresholdBelow": -40.000000,
//			"m_fldbThresholdAbove": -30.000000,
//			"m_flRatioBelow": 12.000000,
//			"m_flRatioAbove": 4.000000,
//			"m_flAttackTimeMS": 50.000000,
//			"m_flReleaseTimeMS": 200.000000,
//			"m_bEnable": false,
//			"m_bSolo": false
//		}
//	]
//}
class VMixDynamics3BandDesc_t
{
	float32 m_fldbGainOutput;
	float32 m_flRMSTimeMS;
	float32 m_fldbKneeWidth;
	float32 m_flDepth;
	float32 m_flWetMix;
	float32 m_flTimeScale;
	float32 m_flLowCutoffFreq;
	float32 m_flHighCutoffFreq;
	bool m_bPeakMode;
	VMixDynamicsBand_t[3] m_bandDesc;
};
