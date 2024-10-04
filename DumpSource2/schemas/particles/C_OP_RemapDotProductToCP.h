class C_OP_RemapDotProductToCP : public CParticleFunctionPreEmission
{
	int32 m_nInputCP1;
	int32 m_nInputCP2;
	int32 m_nOutputCP;
	int32 m_nOutVectorField;
	CParticleCollectionFloatInput m_flInputMin;
	CParticleCollectionFloatInput m_flInputMax;
	CParticleCollectionFloatInput m_flOutputMin;
	CParticleCollectionFloatInput m_flOutputMax;
};
