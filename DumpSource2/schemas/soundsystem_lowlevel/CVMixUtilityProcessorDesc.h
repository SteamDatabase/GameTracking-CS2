// MGetKV3ClassDefaults = {
//	"_class": "CVMixUtilityProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_nOp": "VMIX_CHAN_STEREO",
//		"m_flInputPan": 0.000000,
//		"m_flOutputBalance": 0.000000,
//		"m_fldbOutputGain": 0.000000,
//		"m_bBassMono": false,
//		"m_flBassFreq": 120.000000
//	}
//}
class CVMixUtilityProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixUtilityDesc_t m_desc;
};
