class C_OP_RemapCrossProductOfTwoVectorsToVector : public CParticleFunctionOperator
{
	CPerParticleVecInput m_InputVec1;
	CPerParticleVecInput m_InputVec2;
	ParticleAttributeIndex_t m_nFieldOutput;
	bool m_bNormalize;
};
