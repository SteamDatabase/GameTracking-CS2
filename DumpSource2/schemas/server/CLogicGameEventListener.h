// MNetworkVarNames = "bool m_bEnabled"
class CLogicGameEventListener : public CLogicalEntity
{
	CEntityIOOutput m_OnEventFired;
	CUtlSymbolLarge m_iszGameEventName;
	CUtlSymbolLarge m_iszGameEventItem;
	// MNetworkEnable
	bool m_bEnabled;
	bool m_bStartDisabled;
};
