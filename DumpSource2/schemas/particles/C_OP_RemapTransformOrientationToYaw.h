class C_OP_RemapTransformOrientationToYaw : public CParticleFunctionOperator
{
	CParticleTransformInput m_TransformInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flRotOffset;
	float32 m_flSpinStrength;
};
