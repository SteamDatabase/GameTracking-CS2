// MNetworkVarNames = "int m_nDecoyShotTick"
class CDecoyProjectile : public CBaseCSGrenadeProjectile
{
	// MNetworkEnable
	int32 m_nDecoyShotTick;
	int32 m_shotsRemaining;
	GameTime_t m_fExpireTime;
	uint16 m_decoyWeaponDefIndex;
};
