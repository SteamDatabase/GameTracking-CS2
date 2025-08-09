// MGetKV3ClassDefaults = Could not parse KV3 Defaults
// M_LEGACY_OptInToSchemaPropertyDomain
class CAnimParameterBase
{
	// MPropertyFriendlyName = "Name"
	// MPropertySortPriority = 100
	CGlobalSymbol m_name;
	// MPropertyFriendlyName = "Comment"
	// MPropertyAttributeEditor = "TextBlock()"
	// MPropertySortPriority = -100
	CUtlString m_sComment;
	// MPropertyReadOnly
	CUtlString m_group;
	// MPropertyReadOnly
	AnimParamID m_id;
	// MPropertySuppressField
	// MPropertyAutoRebuildOnChange
	CUtlString m_componentName;
	// MPropertySuppressField
	bool m_bNetworkingRequested;
	// MPropertySuppressField
	bool m_bIsReferenced;
};
