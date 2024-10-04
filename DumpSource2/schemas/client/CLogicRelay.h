class CLogicRelay : public CLogicalEntity
{
	CEntityIOOutput m_OnTrigger;
	CEntityIOOutput m_OnSpawn;
	bool m_bDisabled;
	bool m_bWaitForRefire;
	bool m_bTriggerOnce;
	bool m_bFastRetrigger;
	bool m_bPassthoughCaller;
}
