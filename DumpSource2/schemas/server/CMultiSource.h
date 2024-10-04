class CMultiSource : public CLogicalEntity
{
	CHandle< CBaseEntity >[32] m_rgEntities;
	int32[32] m_rgTriggered;
	CEntityIOOutput m_OnTrigger;
	int32 m_iTotal;
	CUtlSymbolLarge m_globalstate;
};
