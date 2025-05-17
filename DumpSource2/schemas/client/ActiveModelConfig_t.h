// MNetworkVarNames = "ModelConfigHandle_t m_Handle"
// MNetworkVarNames = "string_t m_Name"
// MNetworkVarNames = "CHandle< C_BaseModelEntity > m_AssociatedEntities"
// MNetworkVarNames = "string_t m_AssociatedEntityNames"
class ActiveModelConfig_t
{
	// MNetworkEnable
	ModelConfigHandle_t m_Handle;
	// MNetworkEnable
	CUtlSymbolLarge m_Name;
	// MNetworkEnable
	C_NetworkUtlVectorBase< CHandle< C_BaseModelEntity > > m_AssociatedEntities;
	// MNetworkEnable
	C_NetworkUtlVectorBase< CUtlSymbolLarge > m_AssociatedEntityNames;
};
