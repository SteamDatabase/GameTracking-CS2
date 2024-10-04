class C_INIT_CreateOnGrid : public CParticleFunctionInitializer
{
	CParticleCollectionFloatInput m_nXCount;
	CParticleCollectionFloatInput m_nYCount;
	CParticleCollectionFloatInput m_nZCount;
	CParticleCollectionFloatInput m_nXSpacing;
	CParticleCollectionFloatInput m_nYSpacing;
	CParticleCollectionFloatInput m_nZSpacing;
	int32 m_nControlPointNumber;
	bool m_bLocalSpace;
	bool m_bCenter;
	bool m_bHollow;
};
