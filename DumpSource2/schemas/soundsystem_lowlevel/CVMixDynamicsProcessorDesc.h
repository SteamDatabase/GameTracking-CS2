// MGetKV3ClassDefaults = {
//	"_class": "CVMixDynamicsProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_fldbGain": 0.000000,
//		"m_fldbNoiseGateThreshold": 0.000000,
//		"m_fldbCompressionThreshold": 0.000000,
//		"m_fldbLimiterThreshold": 0.000000,
//		"m_fldbKneeWidth": 0.000000,
//		"m_flRatio": 0.000000,
//		"m_flLimiterRatio": 0.000000,
//		"m_flAttackTimeMS": 0.000000,
//		"m_flReleaseTimeMS": 0.000000,
//		"m_flRMSTimeMS": 0.000000,
//		"m_flWetMix": 0.000000,
//		"m_bPeakMode": false
//	}
//}
class CVMixDynamicsProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixDynamicsDesc_t m_desc;
};
