class CLogicPlayerProxy : public CLogicalEntity
{
	CEntityIOOutput m_PlayerHasAmmo;
	CEntityIOOutput m_PlayerHasNoAmmo;
	CEntityIOOutput m_PlayerDied;
	CEntityOutputTemplate< int32, int32 > m_RequestedPlayerHealth;
	CHandle< CBaseEntity > m_hPlayer;
};
