// MNetworkVarNames = "CHandle< C_BaseModelEntity> m_glowEntity"
// MNetworkVarNames = "bool m_usable"
// MNetworkVarNames = "string_t m_szDisplayText"
class C_BaseButton : public C_BaseToggle
{
	// MNetworkEnable
	CHandle< C_BaseModelEntity > m_glowEntity;
	// MNetworkEnable
	bool m_usable;
	// MNetworkEnable
	CUtlSymbolLarge m_szDisplayText;
};
