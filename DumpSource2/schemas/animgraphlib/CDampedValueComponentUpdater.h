// MGetKV3ClassDefaults = {
//	"_class": "CDampedValueComponentUpdater",
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
class CDampedValueComponentUpdater : public CAnimComponentUpdater
{
	CUtlVector< CDampedValueUpdateItem > m_items;
};
