class C_OP_SetAttributeToScalarExpression : public CParticleFunctionOperator
{
	ScalarExpressionType_t m_nExpression;
	CPerParticleFloatInput m_flInput1;
	CPerParticleFloatInput m_flInput2;
	CParticleRemapFloatInput m_flOutputRemap;
	ParticleAttributeIndex_t m_nOutputField;
	ParticleSetMethod_t m_nSetMethod;
};
