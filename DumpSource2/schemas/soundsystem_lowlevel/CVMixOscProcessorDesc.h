// MGetKV3ClassDefaults = {
//	"_class": "CVMixOscProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"oscType": "LFO_SHAPE_SINE",
//		"m_freq": 440.000000,
//		"m_flPhase": 0.000000
//	}
//}
class CVMixOscProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixOscDesc_t m_desc;
};
