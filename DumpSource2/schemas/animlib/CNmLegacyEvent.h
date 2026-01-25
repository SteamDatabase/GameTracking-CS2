// MGetKV3ClassDefaults = {
//	"_class": "CNmLegacyEvent",
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
//	"m_animEventClassName": "",
//	"m_KV": null
//}
class CNmLegacyEvent : public CNmEvent
{
	CUtlString m_animEventClassName;
	KeyValues3 m_KV;
};
