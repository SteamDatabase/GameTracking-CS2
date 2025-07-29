// MNetworkIncludeByName = "m_spawnflags"
// MNetworkVarNames = "bool m_bDisabled"
class CBaseTrigger : public CBaseToggle
{
	CEntityIOOutput m_OnStartTouch;
	CEntityIOOutput m_OnStartTouchAll;
	CEntityIOOutput m_OnEndTouch;
	CEntityIOOutput m_OnEndTouchAll;
	CEntityIOOutput m_OnTouching;
	CEntityIOOutput m_OnTouchingEachEntity;
	CEntityIOOutput m_OnNotTouching;
	CUtlVector< CHandle< CBaseEntity > > m_hTouchingEntities;
	CUtlSymbolLarge m_iFilterName;
	CHandle< CBaseFilter > m_hFilter;
	// MNetworkEnable
	bool m_bDisabled;
	bool m_bUseAsyncQueries;
};
