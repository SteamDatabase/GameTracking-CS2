class C_INIT_RemapParticleCountToScalar : public CParticleFunctionInitializer
{
	ParticleAttributeIndex_t m_nFieldOutput;
	int32 m_nInputMin;
	int32 m_nInputMax;
	int32 m_nScaleControlPoint;
	int32 m_nScaleControlPointField;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bActiveRange;
	bool m_bInvert;
	bool m_bWrap;
	float32 m_flRemapBias;
};
