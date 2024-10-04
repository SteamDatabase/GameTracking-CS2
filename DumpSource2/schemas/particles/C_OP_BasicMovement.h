class C_OP_BasicMovement : public CParticleFunctionOperator
{
	CParticleCollectionVecInput m_Gravity;
	CParticleCollectionFloatInput m_fDrag;
	CParticleMassCalculationParameters m_massControls;
	int32 m_nMaxConstraintPasses;
	bool m_bUseNewCode;
};
