class CCSCustomHudLayout : public C_BaseEntity
{
	CUtlSymbolLarge m_strLayout;
	C_UtlVectorEmbeddedNetworkVar< CCSCustomHudLayoutState > m_vecPlayerLayoutStates;
	CCSCustomHudLayoutState m_globalLayoutState;
	C_NetworkUtlVectorBase< CUtlString > m_vecPanelIds;
	C_NetworkUtlVectorBase< CUtlString > m_vecClassNames;
	C_NetworkUtlVectorBase< CUtlString > m_vecDialogVariableNames;
};
