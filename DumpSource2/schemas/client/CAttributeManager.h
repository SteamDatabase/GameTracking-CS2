// MNetworkVarNames = "int m_iReapplyProvisionParity"
// MNetworkVarNames = "EHANDLE m_hOuter"
// MNetworkVarNames = "attributeprovidertypes_t m_ProviderType"
class CAttributeManager
{
	CUtlVector< CHandle< C_BaseEntity > > m_Providers;
	// MNetworkEnable
	int32 m_iReapplyProvisionParity;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hOuter;
	bool m_bPreventLoopback;
	// MNetworkEnable
	attributeprovidertypes_t m_ProviderType;
	CUtlVector< CAttributeManager::cached_attribute_float_t > m_CachedResults;
};
