class CLogicAuto : public CBaseEntity
{
	CEntityIOOutput m_OnMapSpawn;
	CEntityIOOutput m_OnDemoMapSpawn;
	CEntityIOOutput m_OnNewGame;
	CEntityIOOutput m_OnLoadGame;
	CEntityIOOutput m_OnMapTransition;
	CEntityIOOutput m_OnBackgroundMap;
	CEntityIOOutput m_OnMultiNewMap;
	CEntityIOOutput m_OnMultiNewRound;
	CEntityIOOutput m_OnVREnabled;
	CEntityIOOutput m_OnVRNotEnabled;
	CUtlSymbolLarge m_globalstate;
}
