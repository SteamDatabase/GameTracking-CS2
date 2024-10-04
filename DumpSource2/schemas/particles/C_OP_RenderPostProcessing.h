class C_OP_RenderPostProcessing : public CParticleFunctionRenderer
{
	CPerParticleFloatInput m_flPostProcessStrength;
	CStrongHandle< InfoForResourceTypeCPostProcessingResource > m_hPostTexture;
	ParticlePostProcessPriorityGroup_t m_nPriority;
};
