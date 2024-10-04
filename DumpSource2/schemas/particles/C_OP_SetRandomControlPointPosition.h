class C_OP_SetRandomControlPointPosition : public CParticleFunctionPreEmission
{
	bool m_bUseWorldLocation;
	bool m_bOrient;
	int32 m_nCP1;
	int32 m_nHeadLocation;
	CParticleCollectionFloatInput m_flReRandomRate;
	Vector m_vecCPMinPos;
	Vector m_vecCPMaxPos;
	CParticleCollectionFloatInput m_flInterpolation;
};
