class C_PlayerPing : public C_BaseEntity
{
	CHandle< C_CSPlayerPawn > m_hPlayer;
	CHandle< C_BaseEntity > m_hPingedEntity;
	int32 m_iType;
	bool m_bUrgent;
	char[18] m_szPlaceName;
}
