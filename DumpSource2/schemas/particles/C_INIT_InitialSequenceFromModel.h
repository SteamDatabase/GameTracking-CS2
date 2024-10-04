class C_INIT_InitialSequenceFromModel : public CParticleFunctionInitializer
{
	int32 m_nControlPointNumber;
	ParticleAttributeIndex_t m_nFieldOutput;
	ParticleAttributeIndex_t m_nFieldOutputAnim;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	ParticleSetMethod_t m_nSetMethod;
};
