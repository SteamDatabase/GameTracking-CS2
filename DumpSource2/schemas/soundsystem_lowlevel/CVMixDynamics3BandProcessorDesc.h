// MGetKV3ClassDefaults = {
//	"_class": "CVMixDynamics3BandProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_fldbGainOutput": 0.000000,
//		"m_flRMSTimeMS": 0.000000,
//		"m_fldbKneeWidth": 0.000000,
//		"m_flDepth": 0.000000,
//		"m_flWetMix": 0.000000,
//		"m_flTimeScale": 0.000000,
//		"m_flLowCutoffFreq": 0.000000,
//		"m_flHighCutoffFreq": 0.000000,
//		"m_bPeakMode": false,
//		"m_bandDesc":
//		[
//			{
//				"m_fldbGainInput": 0.000000,
//				"m_fldbGainOutput": 0.000000,
//				"m_fldbThresholdBelow": -40.000000,
//				"m_fldbThresholdAbove": -30.000000,
//				"m_flRatioBelow": 12.000000,
//				"m_flRatioAbove": 4.000000,
//				"m_flAttackTimeMS": 50.000000,
//				"m_flReleaseTimeMS": 200.000000,
//				"m_bEnable": false,
//				"m_bSolo": false
//			},
//			{
//				"m_fldbGainInput": 0.000000,
//				"m_fldbGainOutput": 0.000000,
//				"m_fldbThresholdBelow": -40.000000,
//				"m_fldbThresholdAbove": -30.000000,
//				"m_flRatioBelow": 12.000000,
//				"m_flRatioAbove": 4.000000,
//				"m_flAttackTimeMS": 50.000000,
//				"m_flReleaseTimeMS": 200.000000,
//				"m_bEnable": false,
//				"m_bSolo": false
//			},
//			{
//				"m_fldbGainInput": 0.000000,
//				"m_fldbGainOutput": 0.000000,
//				"m_fldbThresholdBelow": -40.000000,
//				"m_fldbThresholdAbove": -30.000000,
//				"m_flRatioBelow": 12.000000,
//				"m_flRatioAbove": 4.000000,
//				"m_flAttackTimeMS": 50.000000,
//				"m_flReleaseTimeMS": 200.000000,
//				"m_bEnable": false,
//				"m_bSolo": false
//			}
//		]
//	}
//}
class CVMixDynamics3BandProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixDynamics3BandDesc_t m_desc;
};
