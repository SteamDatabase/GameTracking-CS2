class C_INIT_CreationNoise : public CParticleFunctionInitializer
{
	ParticleAttributeIndex_t m_nFieldOutput;
	bool m_bAbsVal;
	bool m_bAbsValInv;
	float32 m_flOffset;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	float32 m_flNoiseScale;
	float32 m_flNoiseScaleLoc;
	Vector m_vecOffsetLoc;
	float32 m_flWorldTimeScale;
};
