// MGetKV3ClassDefaults = {
//	"_class": "CVMixPlateReverbProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_flPrefilter": 0.000000,
//		"m_flInputDiffusion1": 0.000000,
//		"m_flInputDiffusion2": 0.000000,
//		"m_flDecay": 0.000000,
//		"m_flDamp": 0.000000,
//		"m_flFeedbackDiffusion1": 0.000000,
//		"m_flFeedbackDiffusion2": 0.000000
//	}
//}
class CVMixPlateReverbProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixPlateverbDesc_t m_desc;
};
