// MGetKV3ClassDefaults = {
//	"_class": "CVMixFlangerProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_bPhaseInvert": false,
//		"m_flGlideTime": 0.000000,
//		"m_flDelay": 0.000000,
//		"m_flOutputGain": 0.000000,
//		"m_flFeedbackGain": 0.000000,
//		"m_flFeedforwardGain": 0.000000,
//		"m_flModRate": 0.000000,
//		"m_flModDepth": 0.000000,
//		"m_bApplyAntialiasing": false
//	}
//}
class CVMixFlangerProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixFlangerDesc_t m_desc;
};
