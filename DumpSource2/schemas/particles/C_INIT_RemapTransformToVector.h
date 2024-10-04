class C_INIT_RemapTransformToVector : public CParticleFunctionInitializer
{
	ParticleAttributeIndex_t m_nFieldOutput;
	Vector m_vInputMin;
	Vector m_vInputMax;
	Vector m_vOutputMin;
	Vector m_vOutputMax;
	CParticleTransformInput m_TransformInput;
	CParticleTransformInput m_LocalSpaceTransform;
	float32 m_flStartTime;
	float32 m_flEndTime;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bOffset;
	bool m_bAccelerate;
	float32 m_flRemapBias;
};
