class CSensorGrenadeProjectile : public CBaseCSGrenadeProjectile
{
	GameTime_t m_fExpireTime;
	GameTime_t m_fNextDetectPlayerSound;
	CHandle< CBaseEntity > m_hDisplayGrenade;
};
