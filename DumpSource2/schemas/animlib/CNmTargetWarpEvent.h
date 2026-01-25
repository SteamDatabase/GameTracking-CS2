// MGetKV3ClassDefaults = {
//	"_class": "CNmTargetWarpEvent",
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
//	"m_rule": "WarpXYZ",
//	"m_algorithm": "Bezier"
//}
class CNmTargetWarpEvent : public CNmEvent
{
	NmTargetWarpRule_t m_rule;
	NmTargetWarpAlgorithm_t m_algorithm;
};
