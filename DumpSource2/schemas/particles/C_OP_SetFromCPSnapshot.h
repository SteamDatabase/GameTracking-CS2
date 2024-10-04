class C_OP_SetFromCPSnapshot : public CParticleFunctionOperator
{
	int32 m_nControlPointNumber;
	ParticleAttributeIndex_t m_nAttributeToRead;
	ParticleAttributeIndex_t m_nAttributeToWrite;
	int32 m_nLocalSpaceCP;
	bool m_bRandom;
	bool m_bReverse;
	int32 m_nRandomSeed;
	CParticleCollectionFloatInput m_nSnapShotStartPoint;
	CParticleCollectionFloatInput m_nSnapShotIncrement;
	CPerParticleFloatInput m_flInterpolation;
	bool m_bSubSample;
	bool m_bPrev;
};
