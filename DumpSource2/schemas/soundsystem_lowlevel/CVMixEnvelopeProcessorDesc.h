// MGetKV3ClassDefaults = {
//	"_class": "CVMixEnvelopeProcessorDesc",
//	"m_name": "",
//	"m_nChannels": -1,
//	"m_flxfade": 0.100000,
//	"m_desc":
//	{
//		"m_flAttackTimeMS": 0.000000,
//		"m_flHoldTimeMS": 0.000000,
//		"m_flReleaseTimeMS": 0.000000
//	}
//}
class CVMixEnvelopeProcessorDesc : public CVMixBaseProcessorDesc
{
	VMixEnvelopeDesc_t m_desc;
};
