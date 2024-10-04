class C_OP_RemapCPtoVector : public CParticleFunctionOperator
{
	int32 m_nCPInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	int32 m_nLocalSpaceCP;
	Vector m_vInputMin;
	Vector m_vInputMax;
	Vector m_vOutputMin;
	Vector m_vOutputMax;
	float32 m_flStartTime;
	float32 m_flEndTime;
	float32 m_flInterpRate;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bOffset;
	bool m_bAccelerate;
};
