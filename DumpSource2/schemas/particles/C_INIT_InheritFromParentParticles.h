class C_INIT_InheritFromParentParticles : public CParticleFunctionInitializer
{
	float32 m_flScale;
	ParticleAttributeIndex_t m_nFieldOutput;
	int32 m_nIncrement;
	bool m_bRandomDistribution;
	int32 m_nRandomSeed;
};
