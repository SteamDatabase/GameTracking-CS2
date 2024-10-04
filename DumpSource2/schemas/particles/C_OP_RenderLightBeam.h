class C_OP_RenderLightBeam : public CParticleFunctionRenderer
{
	CParticleCollectionVecInput m_vColorBlend;
	ParticleColorBlendType_t m_nColorBlendType;
	CParticleCollectionFloatInput m_flBrightnessLumensPerMeter;
	bool m_bCastShadows;
	CParticleCollectionFloatInput m_flSkirt;
	CParticleCollectionFloatInput m_flRange;
	CParticleCollectionFloatInput m_flThickness;
};
