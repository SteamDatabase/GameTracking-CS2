class CGamePlayerZone : public CRuleBrushEntity
{
	CEntityIOOutput m_OnPlayerInZone;
	CEntityIOOutput m_OnPlayerOutZone;
	CEntityOutputTemplate< int32, int32 > m_PlayersInCount;
	CEntityOutputTemplate< int32, int32 > m_PlayersOutCount;
};
