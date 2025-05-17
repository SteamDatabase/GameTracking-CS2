// MNetworkIncludeByName = "m_spawnflags"
// MNetworkVarNames = "bool m_bDisabled"
// MNetworkVarNames = "bool m_bClientSidePredicted"
class CBaseTrigger : public CBaseToggle
{
	// MNetworkEnable
	bool m_bDisabled;
	CUtlSymbolLarge m_iFilterName;
	CHandle< CBaseFilter > m_hFilter;
	CEntityIOOutput m_OnStartTouch;
	CEntityIOOutput m_OnStartTouchAll;
	CEntityIOOutput m_OnEndTouch;
	CEntityIOOutput m_OnEndTouchAll;
	CEntityIOOutput m_OnTouching;
	CEntityIOOutput m_OnTouchingEachEntity;
	CEntityIOOutput m_OnNotTouching;
	CUtlVector< CHandle< CBaseEntity > > m_hTouchingEntities;
	// MNetworkEnable
	bool m_bClientSidePredicted;
};
