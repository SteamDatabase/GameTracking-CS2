class C_INIT_SetHitboxToClosest : public CParticleFunctionInitializer
{
	int32 m_nControlPointNumber;
	int32 m_nDesiredHitbox;
	CParticleCollectionVecInput m_vecHitBoxScale;
	char[128] m_HitboxSetName;
	bool m_bUseBones;
	bool m_bUseClosestPointOnHitbox;
	ClosestPointTestType_t m_nTestType;
	CParticleCollectionFloatInput m_flHybridRatio;
	bool m_bUpdatePosition;
};
