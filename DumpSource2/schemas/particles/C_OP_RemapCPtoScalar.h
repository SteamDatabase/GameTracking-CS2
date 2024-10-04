class C_OP_RemapCPtoScalar : public CParticleFunctionOperator
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
	float32 m_flInterpRate;
	ParticleSetMethod_t m_nSetMethod;
};
