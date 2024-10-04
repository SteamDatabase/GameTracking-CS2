class C_OP_SetFloatAttributeToVectorExpression : public CParticleFunctionOperator
{
	VectorFloatExpressionType_t m_nExpression;
	CPerParticleVecInput m_vInput1;
	CPerParticleVecInput m_vInput2;
	CParticleRemapFloatInput m_flOutputRemap;
	ParticleAttributeIndex_t m_nOutputField;
	ParticleSetMethod_t m_nSetMethod;
};
