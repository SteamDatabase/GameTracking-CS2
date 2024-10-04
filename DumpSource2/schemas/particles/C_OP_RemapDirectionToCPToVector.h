class C_OP_RemapDirectionToCPToVector : public CParticleFunctionOperator
{
	int32 m_nCP;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flScale;
	float32 m_flOffsetRot;
	Vector m_vecOffsetAxis;
	bool m_bNormalize;
	ParticleAttributeIndex_t m_nFieldStrength;
};
