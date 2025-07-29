// MNetworkVarNames = "CEntityIdentity * m_pEntity"
// MNetworkVarNames = "CScriptComponent::Storage_t m_CScriptComponent"
class CEntityInstance
{
	CUtlSymbolLarge m_iszPrivateVScripts;
	// MNetworkEnable
	// MNetworkPriority = 56
	CEntityIdentity* m_pEntity;
	CScriptComponent* m_CScriptComponent;
};
