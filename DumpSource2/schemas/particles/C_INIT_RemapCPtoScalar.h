class C_INIT_RemapCPtoScalar : public CParticleFunctionInitializer
{
	int32 m_nCPInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	int32 m_nField;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	float32 m_flStartTime;
	float32 m_flEndTime;
	ParticleSetMethod_t m_nSetMethod;
	float32 m_flRemapBias;
};
