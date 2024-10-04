class C_OP_RemapDotProductToScalar : public CParticleFunctionOperator
{
	int32 m_nInputCP1;
	int32 m_nInputCP2;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	bool m_bUseParticleVelocity;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bActiveRange;
	bool m_bUseParticleNormal;
};
