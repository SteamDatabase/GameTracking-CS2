class C_INIT_SetVectorAttributeToVectorExpression : public CParticleFunctionInitializer
{
	VectorExpressionType_t m_nExpression;
	CPerParticleVecInput m_vInput1;
	CPerParticleVecInput m_vInput2;
	ParticleAttributeIndex_t m_nOutputField;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bNormalizedOutput;
};
