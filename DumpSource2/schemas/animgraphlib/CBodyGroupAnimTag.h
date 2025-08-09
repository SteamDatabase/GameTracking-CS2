// MGetKV3ClassDefaults = {
//	"_class": "CBodyGroupAnimTag",
//	"m_name": "Unnamed Tag",
//	"m_sComment": "",
//	"m_group": "",
//	"m_tagID":
//	{
//		"m_id": 4294967295
//	},
//	"m_bIsReferenced": false,
//	"m_nPriority": 5,
//	"m_bodyGroupSettings":
//	[
//	]
//}
// MPropertyFriendlyName = "Body Group Tag"
// M_LEGACY_OptInToSchemaPropertyDomain
class CBodyGroupAnimTag : public CAnimTagBase
{
	// MPropertyFriendlyName = "Priority"
	int32 m_nPriority;
	// MPropertyFriendlyName = "Body Group Settings"
	CUtlVector< CBodyGroupSetting > m_bodyGroupSettings;
};
