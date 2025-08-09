// MGetKV3ClassDefaults = {
//	"_class": "CCPPScriptComponentUpdater",
//	"m_name": "",
//	"m_id":
//	{
//		"m_id": 4294967295
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_bStartEnabled": false,
//	"m_scriptsToRun":
//	[
//	]
//}
class CCPPScriptComponentUpdater : public CAnimComponentUpdater
{
	// MPropertyFriendlyName = "Scripts"
	CUtlVector< CGlobalSymbol > m_scriptsToRun;
};
