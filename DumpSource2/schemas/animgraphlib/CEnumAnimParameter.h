// M_LEGACY_OptInToSchemaPropertyDomain
// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Enum Parameter"
class CEnumAnimParameter : public CConcreteAnimParameter
{
	// MPropertyFriendlyName = "Default Value"
	uint8 m_defaultValue;
	// MPropertyFriendlyName = "Values"
	// MPropertyAttrChangeCallback (UNKNOWN FOR PARSER)
	CUtlVector< CUtlString > m_enumOptions;
	// MPropertySuppressField
	CUtlVector< uint64 > m_vecEnumReferenced;
};
