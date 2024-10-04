class CCSPlayer_UseServices : public CPlayer_UseServices
{
	CHandle< CBaseEntity > m_hLastKnownUseEntity;
	GameTime_t m_flLastUseTimeStamp;
	GameTime_t m_flTimeLastUsedWindow;
}
