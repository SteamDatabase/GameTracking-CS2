// MNetworkVarNames = "CEntityIdentity * m_pEntity"
// MNetworkVarNames = "CScriptComponent::Storage_t m_CScriptComponent"
class CEntityInstance
{
	// MNetworkDisable
	CUtlSymbolLarge m_iszPrivateVScripts;
	// MNetworkEnable
	// MNetworkPriority = 56
	CEntityIdentity* m_pEntity;
	// MNetworkEnable
	// MNetworkDisable
	CScriptComponent* m_CScriptComponent;
	bool m_bVisibleinPVS;
};
