class C_OP_PinParticleToCP : public CParticleFunctionOperator
{
	int32 m_nControlPointNumber;
	CParticleCollectionVecInput m_vecOffset;
	bool m_bOffsetLocal;
	ParticleSelection_t m_nParticleSelection;
	CParticleCollectionFloatInput m_nParticleNumber;
	ParticlePinDistance_t m_nPinBreakType;
	CParticleCollectionFloatInput m_flBreakDistance;
	CParticleCollectionFloatInput m_flBreakSpeed;
	CParticleCollectionFloatInput m_flAge;
	int32 m_nBreakControlPointNumber;
	int32 m_nBreakControlPointNumber2;
	CParticleCollectionFloatInput m_flBreakValue;
	CPerParticleFloatInput m_flInterpolation;
};
