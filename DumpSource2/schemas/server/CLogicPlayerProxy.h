class CLogicPlayerProxy : public CLogicalEntity
{
	CHandle< CBaseEntity > m_hPlayer;
	CEntityIOOutput m_PlayerHasAmmo;
	CEntityIOOutput m_PlayerHasNoAmmo;
	CEntityIOOutput m_PlayerDied;
	CEntityOutputTemplate< int32 > m_RequestedPlayerHealth;
};
