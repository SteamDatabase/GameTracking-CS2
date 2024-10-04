class C_INIT_CreateSequentialPathV2 : public CParticleFunctionInitializer
{
	CPerParticleFloatInput m_fMaxDistance;
	CParticleCollectionFloatInput m_flNumToAssign;
	bool m_bLoop;
	bool m_bCPPairs;
	bool m_bSaveOffset;
	CPathParameters m_PathParams;
};
