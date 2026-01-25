// MGetKV3ClassDefaults = {
//	"_class": "CVMixPitchShiftProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_nGrainSampleCount": 0,
//		"m_flPitchShift": 0.000000,
//		"m_nQuality": 0,
//		"m_nProcType": 0
//	}
//}
class CVMixPitchShiftProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixPitchShiftDesc_t m_desc;
};
