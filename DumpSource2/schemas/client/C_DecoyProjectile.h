class C_DecoyProjectile : public C_BaseCSGrenadeProjectile
{
	int32 m_nDecoyShotTick;
	int32 m_nClientLastKnownDecoyShotTick;
	GameTime_t m_flTimeParticleEffectSpawn;
}
