// MGetKV3ClassDefaults = Could not parse KV3 Defaults
// M_LEGACY_OptInToSchemaPropertyDomain
class CConcreteAnimParameter : public CAnimParameterBase
{
	// MPropertyFriendlyName = "Preview Button"
	AnimParamButton_t m_previewButton;
	// MPropertyFriendlyName = "Network"
	AnimParamNetworkSetting m_eNetworkSetting;
	// MPropertyFriendlyName = "Force Latest Value"
	bool m_bUseMostRecentValue;
	// MPropertyFriendlyName = "Auto Reset"
	bool m_bAutoReset;
	// MPropertyFriendlyName = "Game Writable"
	// MPropertyGroupName = "+Permissions"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	bool m_bGameWritable;
	// MPropertyFriendlyName = "Graph Writable"
	// MPropertyGroupName = "+Permissions"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	bool m_bGraphWritable;
};
