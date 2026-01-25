// MGetKV3ClassDefaults = {
//	"_class": "CVMixConvolutionProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_fldbGain": -12.000000,
//		"m_flPreDelayMS": 0.000000,
//		"m_flWetMix": 1.000000,
//		"m_fldbLow": 0.000000,
//		"m_fldbMid": 0.000000,
//		"m_fldbHigh": 0.000000,
//		"m_flLowCutoffFreq": 1500.000000,
//		"m_flHighCutoffFreq": 7500.000000
//	}
//}
class CVMixConvolutionProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixConvolutionDesc_t m_desc;
};
