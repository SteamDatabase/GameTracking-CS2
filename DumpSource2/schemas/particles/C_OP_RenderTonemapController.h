class C_OP_RenderTonemapController : public CParticleFunctionRenderer
{
	float32 m_flTonemapLevel;
	float32 m_flTonemapWeight;
	ParticleAttributeIndex_t m_nTonemapLevelField;
	ParticleAttributeIndex_t m_nTonemapWeightField;
};
