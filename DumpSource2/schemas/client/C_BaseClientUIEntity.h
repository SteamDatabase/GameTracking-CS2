// MNetworkVarNames = "bool m_bEnabled"
// MNetworkVarNames = "string_t m_DialogXMLName"
// MNetworkVarNames = "string_t m_PanelClassName"
// MNetworkVarNames = "string_t m_PanelID"
class C_BaseClientUIEntity : public C_BaseModelEntity
{
	// MNetworkEnable
	bool m_bEnabled;
	// MNetworkEnable
	CUtlSymbolLarge m_DialogXMLName;
	// MNetworkEnable
	CUtlSymbolLarge m_PanelClassName;
	// MNetworkEnable
	CUtlSymbolLarge m_PanelID;
};
