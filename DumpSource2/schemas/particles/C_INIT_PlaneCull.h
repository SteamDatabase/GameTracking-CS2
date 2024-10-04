class C_INIT_PlaneCull : public CParticleFunctionInitializer
{
	int32 m_nControlPoint;
	CParticleCollectionFloatInput m_flDistance;
	bool m_bCullInside;
};
