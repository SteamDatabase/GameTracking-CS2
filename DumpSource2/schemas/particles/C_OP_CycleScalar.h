class C_OP_CycleScalar : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nDestField;
	float32 m_flStartValue;
	float32 m_flEndValue;
	float32 m_flCycleTime;
	bool m_bDoNotRepeatCycle;
	bool m_bSynchronizeParticles;
	int32 m_nCPScale;
	int32 m_nCPFieldMin;
	int32 m_nCPFieldMax;
	ParticleSetMethod_t m_nSetMethod;
};
