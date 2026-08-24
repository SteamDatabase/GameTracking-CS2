class CCSPlayerCamera : public CBaseEntity
{
	CHandle< CCSPlayerPawnBase > m_hPawn;
	bool m_bEnabled;
	bool m_bIsControllingAngles;
};
