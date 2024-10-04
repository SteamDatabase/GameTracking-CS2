class C_OP_ConstrainDistance : public CParticleFunctionConstraint
{
	CParticleCollectionFloatInput m_fMinDistance;
	CParticleCollectionFloatInput m_fMaxDistance;
	int32 m_nControlPointNumber;
	Vector m_CenterOffset;
	bool m_bGlobalCenter;
};
