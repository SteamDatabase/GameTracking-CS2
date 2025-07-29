// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyElementNameFn (UNKNOWN FOR PARSER)
class CompositeMaterialInputContainer_t
{
	// MPropertyAutoRebuildOnChange
	// MPropertyFriendlyName = "Enabled"
	bool m_bEnabled;
	// MPropertyAutoRebuildOnChange
	// MPropertyFriendlyName = "Input Container Source"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CompositeMaterialInputContainerSourceType_t m_nCompositeMaterialInputContainerSourceType;
	// MPropertyFriendlyName = "Specific Material"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeIMaterial2 > > m_strSpecificContainerMaterial;
	// MPropertyFriendlyName = "Attribute Name"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strAttrName;
	// MPropertyFriendlyName = "Alias"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strAlias;
	// MPropertyFriendlyName = "Variables"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlVector< CompositeMaterialInputLooseVariable_t > m_vecLooseVariables;
	// MPropertyFriendlyName = "Attribute Name"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strAttrNameForVar;
	// MPropertyFriendlyName = "Expose Externally"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	bool m_bExposeExternally;
};
