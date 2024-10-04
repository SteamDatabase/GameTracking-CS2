class C_INIT_RemapScalarToVector : public CParticleFunctionInitializer
{
	ParticleAttributeIndex_t m_nFieldInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flInputMin;
	float32 m_flInputMax;
	Vector m_vecOutputMin;
	Vector m_vecOutputMax;
	float32 m_flStartTime;
	float32 m_flEndTime;
	ParticleSetMethod_t m_nSetMethod;
	int32 m_nControlPointNumber;
	bool m_bLocalCoords;
	float32 m_flRemapBias;
};
