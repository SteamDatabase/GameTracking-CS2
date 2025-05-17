// MNetworkVarNames = "int m_nDecoyShotTick"
class C_DecoyProjectile : public C_BaseCSGrenadeProjectile
{
	// MNetworkEnable
	int32 m_nDecoyShotTick;
	int32 m_nClientLastKnownDecoyShotTick;
	GameTime_t m_flTimeParticleEffectSpawn;
};
