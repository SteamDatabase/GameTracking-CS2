// MNetworkVarNames = "ModelConfigHandle_t m_Handle"
// MNetworkVarNames = "string_t m_Name"
// MNetworkVarNames = "CHandle< CBaseModelEntity > m_AssociatedEntities"
// MNetworkVarNames = "string_t m_AssociatedEntityNames"
class ActiveModelConfig_t
{
	// MNetworkEnable
	ModelConfigHandle_t m_Handle;
	// MNetworkEnable
	CUtlSymbolLarge m_Name;
	// MNetworkEnable
	CNetworkUtlVectorBase< CHandle< CBaseModelEntity > > m_AssociatedEntities;
	// MNetworkEnable
	CNetworkUtlVectorBase< CUtlSymbolLarge > m_AssociatedEntityNames;
};
