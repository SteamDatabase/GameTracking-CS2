// MGetKV3ClassDefaults = {
//	"_class": "CAnimTagBase",
//	"m_name": "Unnamed Tag",
//	"m_sComment": "",
//	"m_group": "",
//	"m_tagID":
//	{
//		"m_id": 4294967295
//	},
//	"m_bIsReferenced": false
//}
// M_LEGACY_OptInToSchemaPropertyDomain
class CAnimTagBase
{
	// MPropertyFriendlyName = "Name"
	// MPropertySortPriority = 100
	CGlobalSymbol m_name;
	// MPropertyFriendlyName = "Comment"
	// MPropertyAttributeEditor = "TextBlock()"
	// MPropertySortPriority = -100
	CUtlString m_sComment;
	// MPropertySuppressField
	CGlobalSymbol m_group;
	// MPropertySuppressField
	AnimTagID m_tagID;
	// MPropertySuppressField
	bool m_bIsReferenced;
};
