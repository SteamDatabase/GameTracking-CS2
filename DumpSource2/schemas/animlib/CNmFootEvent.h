// MGetKV3ClassDefaults = {
//	"_class": "CNmFootEvent",
//	"m_flStartTimeSeconds": 0.000000,
//	"m_flDurationSeconds": 0.000000,
//	"m_syncID": "",
//	"m_bClientOnly": false,
//	"m_phase": "LeftFootDown"
//}
class CNmFootEvent : public CNmEvent
{
	NmFootPhase_t m_phase;
};
