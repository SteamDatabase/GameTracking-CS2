class C_OP_RemapCPVelocityToVector : public CParticleFunctionOperator
{
	int32 m_nControlPoint;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flScale;
	bool m_bNormalize;
};
