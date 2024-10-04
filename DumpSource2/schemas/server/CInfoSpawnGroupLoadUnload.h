class CInfoSpawnGroupLoadUnload : public CLogicalEntity
{
	CEntityIOOutput m_OnSpawnGroupLoadStarted;
	CEntityIOOutput m_OnSpawnGroupLoadFinished;
	CEntityIOOutput m_OnSpawnGroupUnloadStarted;
	CEntityIOOutput m_OnSpawnGroupUnloadFinished;
	CUtlSymbolLarge m_iszSpawnGroupName;
	CUtlSymbolLarge m_iszSpawnGroupFilterName;
	CUtlSymbolLarge m_iszLandmarkName;
	CUtlString m_sFixedSpawnGroupName;
	float32 m_flTimeoutInterval;
	bool m_bStreamingStarted;
	bool m_bUnloadingStarted;
}
