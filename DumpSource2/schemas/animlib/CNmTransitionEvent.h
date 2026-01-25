// MGetKV3ClassDefaults = {
//	"_class": "CNmTransitionEvent",
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
//	"m_rule": "BlockTransition",
//	"m_ID": ""
//}
class CNmTransitionEvent : public CNmEvent
{
	NmTransitionRule_t m_rule;
	CGlobalSymbol m_ID;
};
