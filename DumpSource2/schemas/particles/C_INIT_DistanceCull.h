class C_INIT_DistanceCull : public CParticleFunctionInitializer
{
	int32 m_nControlPoint;
	CParticleCollectionFloatInput m_flDistance;
	bool m_bCullInside;
};
