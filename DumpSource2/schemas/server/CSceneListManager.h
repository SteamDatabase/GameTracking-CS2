class CSceneListManager : public CLogicalEntity
{
	CUtlVector< CHandle< CSceneListManager > > m_hListManagers;
	CUtlSymbolLarge[16] m_iszScenes;
	CHandle< CBaseEntity >[16] m_hScenes;
}
