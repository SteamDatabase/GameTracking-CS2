class CAttributeManager
{
	CUtlVector< CHandle< CBaseEntity > > m_Providers;
	int32 m_iReapplyProvisionParity;
	CHandle< CBaseEntity > m_hOuter;
	bool m_bPreventLoopback;
	attributeprovidertypes_t m_ProviderType;
	CUtlVector< CAttributeManager::cached_attribute_float_t > m_CachedResults;
};