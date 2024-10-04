class C_EntityDissolve : public C_BaseModelEntity
{
	GameTime_t m_flStartTime;
	float32 m_flFadeInStart;
	float32 m_flFadeInLength;
	float32 m_flFadeOutModelStart;
	float32 m_flFadeOutModelLength;
	float32 m_flFadeOutStart;
	float32 m_flFadeOutLength;
	GameTime_t m_flNextSparkTime;
	EntityDisolveType_t m_nDissolveType;
	Vector m_vDissolverOrigin;
	uint32 m_nMagnitude;
	bool m_bCoreExplode;
	bool m_bLinkedToServerEnt;
}
