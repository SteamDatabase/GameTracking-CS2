// M_LEGACY_OptInToSchemaPropertyDomain
// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupMatchPattern",
//	"m_bMatchEventName": false,
//	"m_bMatchEventSubString": false,
//	"m_bMatchEntIndex": false,
//	"m_bMatchOpvar": false,
//	"m_bMatchString": false,
//	"m_matchSoundEventName": "",
//	"m_matchSoundEventSubString": "",
//	"m_flEntIndex": -1.000000,
//	"m_flOpvar": -1.000000,
//	"m_opvarString": ""
//}
class CSosGroupMatchPattern : public CSosGroupBranchPattern
{
	// MPropertyFriendlyName = "Event Name"
	CUtlString m_matchSoundEventName;
	// MPropertyFriendlyName = "Sub-String"
	CUtlString m_matchSoundEventSubString;
	// MPropertyFriendlyName = "Source Entity Index"
	float32 m_flEntIndex;
	// MPropertyFriendlyName = "Opvar Float"
	float32 m_flOpvar;
	// MPropertyFriendlyName = "Opvar String"
	CUtlString m_opvarString;
};
