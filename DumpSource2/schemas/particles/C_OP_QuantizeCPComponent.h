class C_OP_QuantizeCPComponent : public CParticleFunctionPreEmission
{
	CParticleCollectionFloatInput m_flInputValue;
	int32 m_nCPOutput;
	int32 m_nOutVectorField;
	CParticleCollectionFloatInput m_flQuantizeValue;
};
