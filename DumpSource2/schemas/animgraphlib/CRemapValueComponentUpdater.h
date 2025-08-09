// MGetKV3ClassDefaults = {
//	"_class": "CRemapValueComponentUpdater",
//	"m_name": "",
//	"m_id":
//	{
//		"m_id": 4294967295
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_bStartEnabled": false,
//	"m_items":
//	[
//	]
//}
class CRemapValueComponentUpdater : public CAnimComponentUpdater
{
	CUtlVector< CRemapValueUpdateItem > m_items;
};
