class CFogVolume : public CServerOnlyModelEntity
{
	CUtlSymbolLarge m_fogName;
	CUtlSymbolLarge m_postProcessName;
	CUtlSymbolLarge m_colorCorrectionName;
	bool m_bDisabled;
	bool m_bInFogVolumesList;
};
