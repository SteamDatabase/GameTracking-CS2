class C_OP_SetFloatCollection : public CParticleFunctionOperator
{
	CParticleCollectionFloatInput m_InputValue;
	ParticleAttributeIndex_t m_nOutputField;
	ParticleSetMethod_t m_nSetMethod;
	CParticleCollectionFloatInput m_Lerp;
};
