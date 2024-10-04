class C_INIT_RemapScalar : public CParticleFunctionInitializer
{
	ParticleAttributeIndex_t m_nFieldInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	float32 m_flStartTime;
	float32 m_flEndTime;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bActiveRange;
	float32 m_flRemapBias;
};
