class C_OP_RemapScalarOnceTimed : public CParticleFunctionOperator
{
	bool m_bProportional;
	ParticleAttributeIndex_t m_nFieldInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	float32 m_flRemapTime;
};
