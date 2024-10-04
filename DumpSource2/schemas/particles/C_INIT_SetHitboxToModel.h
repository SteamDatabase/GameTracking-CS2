class C_INIT_SetHitboxToModel : public CParticleFunctionInitializer
{
	int32 m_nControlPointNumber;
	int32 m_nForceInModel;
	bool m_bEvenDistribution;
	int32 m_nDesiredHitbox;
	CParticleCollectionVecInput m_vecHitBoxScale;
	Vector m_vecDirectionBias;
	bool m_bMaintainHitbox;
	bool m_bUseBones;
	char[128] m_HitboxSetName;
	CParticleCollectionFloatInput m_flShellSize;
};
