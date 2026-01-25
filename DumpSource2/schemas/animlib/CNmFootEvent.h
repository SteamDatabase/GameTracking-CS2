// MGetKV3ClassDefaults = {
//	"_class": "CNmFootEvent",
//	"m_flStartTime":
//	{
//		"m_flValue": 0.000000
//	},
//	"m_flDuration":
//	{
//		"m_flValue": 0.000000
//	},
//	"m_syncID": "",
//	"m_bClientOnly": false,
//	"m_phase": "LeftFootDown"
//}
class CNmFootEvent : public CNmEvent
{
	NmFootPhase_t m_phase;
};
