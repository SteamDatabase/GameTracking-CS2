class CEntityDissolve : public CBaseModelEntity
{
	float32 m_flFadeInStart;
	float32 m_flFadeInLength;
	float32 m_flFadeOutModelStart;
	float32 m_flFadeOutModelLength;
	float32 m_flFadeOutStart;
	float32 m_flFadeOutLength;
	GameTime_t m_flStartTime;
	EntityDisolveType_t m_nDissolveType;
	Vector m_vDissolverOrigin;
	uint32 m_nMagnitude;
}
