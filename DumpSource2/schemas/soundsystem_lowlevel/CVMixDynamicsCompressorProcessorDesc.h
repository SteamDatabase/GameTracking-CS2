// MGetKV3ClassDefaults = {
//	"_class": "CVMixDynamicsCompressorProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_fldbOutputGain": 0.000000,
//		"m_fldbCompressionThreshold": -6.000000,
//		"m_fldbKneeWidth": 0.000000,
//		"m_flCompressionRatio": 2.000000,
//		"m_flAttackTimeMS": 100.000000,
//		"m_flReleaseTimeMS": 400.000000,
//		"m_flRMSTimeMS": 300.000000,
//		"m_flWetMix": 1.000000,
//		"m_bPeakMode": false
//	}
//}
class CVMixDynamicsCompressorProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixDynamicsCompressorDesc_t m_desc;
};
