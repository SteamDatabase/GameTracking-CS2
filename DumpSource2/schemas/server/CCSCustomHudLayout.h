class CCSCustomHudLayout : public CBaseEntity
{
	CUtlSymbolLarge m_strLayout;
	CUtlVectorEmbeddedNetworkVar< CCSCustomHudLayoutState > m_vecPlayerLayoutStates;
	CCSCustomHudLayoutState m_globalLayoutState;
	CNetworkUtlVectorBase< CUtlString > m_vecPanelIds;
	CNetworkUtlVectorBase< CUtlString > m_vecClassNames;
	CNetworkUtlVectorBase< CUtlString > m_vecDialogVariableNames;
};
