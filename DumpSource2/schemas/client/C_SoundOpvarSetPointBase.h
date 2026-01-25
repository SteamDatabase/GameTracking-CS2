// MNetworkVarNames = "string_t m_iszStackName"
// MNetworkVarNames = "string_t m_iszOperatorName"
// MNetworkVarNames = "string_t m_iszOpvarName"
// MNetworkVarNames = "int m_iOpvarIndex"
// MNetworkVarNames = "bool m_bUseAutoCompare"
// MNetworkVarNames = "bool m_bFastRefresh"
class C_SoundOpvarSetPointBase : public C_BaseEntity
{
	// MNetworkEnable
	CUtlSymbolLarge m_iszStackName;
	// MNetworkEnable
	CUtlSymbolLarge m_iszOperatorName;
	// MNetworkEnable
	CUtlSymbolLarge m_iszOpvarName;
	// MNetworkEnable
	int32 m_iOpvarIndex;
	// MNetworkEnable
	bool m_bUseAutoCompare;
	// MNetworkEnable
	bool m_bFastRefresh;
};
