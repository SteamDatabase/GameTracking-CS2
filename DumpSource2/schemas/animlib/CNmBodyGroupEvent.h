// MGetKV3ClassDefaults = {
//	"_class": "CNmBodyGroupEvent",
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
//	"m_groupName": "",
//	"m_nGroupValue": 0
//}
class CNmBodyGroupEvent : public CNmEvent
{
	CUtlString m_groupName;
	int32 m_nGroupValue;
};
