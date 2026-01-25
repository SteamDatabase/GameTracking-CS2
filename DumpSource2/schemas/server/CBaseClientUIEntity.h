// MNetworkVarNames = "bool m_bEnabled"
// MNetworkVarNames = "string_t m_DialogXMLName"
// MNetworkVarNames = "string_t m_PanelClassName"
// MNetworkVarNames = "string_t m_PanelID"
class CBaseClientUIEntity : public CBaseModelEntity
{
	// MNetworkEnable
	bool m_bEnabled;
	// MNetworkEnable
	CUtlSymbolLarge m_DialogXMLName;
	// MNetworkEnable
	CUtlSymbolLarge m_PanelClassName;
	// MNetworkEnable
	CUtlSymbolLarge m_PanelID;
	CEntityOutputTemplate< CUtlString, char* > m_CustomOutput0;
	CEntityOutputTemplate< CUtlString, char* > m_CustomOutput1;
	CEntityOutputTemplate< CUtlString, char* > m_CustomOutput2;
	CEntityOutputTemplate< CUtlString, char* > m_CustomOutput3;
	CEntityOutputTemplate< CUtlString, char* > m_CustomOutput4;
	CEntityOutputTemplate< CUtlString, char* > m_CustomOutput5;
	CEntityOutputTemplate< CUtlString, char* > m_CustomOutput6;
	CEntityOutputTemplate< CUtlString, char* > m_CustomOutput7;
	CEntityOutputTemplate< CUtlString, char* > m_CustomOutput8;
	CEntityOutputTemplate< CUtlString, char* > m_CustomOutput9;
};
