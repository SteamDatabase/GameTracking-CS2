// MGetKV3ClassDefaults = {
//	"_class": "CVMixDualCompressorProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_flRMSTimeMS": 300.000000,
//		"m_fldbKneeWidth": 0.000000,
//		"m_flWetMix": 1.000000,
//		"m_bPeakMode": false,
//		"m_bandDesc":
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
//	}
//}
class CVMixDualCompressorProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixDualCompressorDesc_t m_desc;
};
