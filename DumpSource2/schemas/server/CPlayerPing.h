class CPlayerPing : public CBaseEntity
{
	CHandle< CCSPlayerPawn > m_hPlayer;
	CHandle< CBaseEntity > m_hPingedEntity;
	int32 m_iType;
	bool m_bUrgent;
	char[18] m_szPlaceName;
}
