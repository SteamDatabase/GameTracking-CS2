class C_OP_RenderOmni2Light : public CParticleFunctionRenderer
{
	ParticleOmni2LightTypeChoiceList_t m_nLightType;
	CParticleCollectionVecInput m_vColorBlend;
	ParticleColorBlendType_t m_nColorBlendType;
	ParticleLightUnitChoiceList_t m_nBrightnessUnit;
	CPerParticleFloatInput m_flBrightnessLumens;
	CPerParticleFloatInput m_flBrightnessCandelas;
	bool m_bCastShadows;
	bool m_bFog;
	CPerParticleFloatInput m_flFogScale;
	CPerParticleFloatInput m_flLuminaireRadius;
	CPerParticleFloatInput m_flSkirt;
	CPerParticleFloatInput m_flRange;
	CPerParticleFloatInput m_flInnerConeAngle;
	CPerParticleFloatInput m_flOuterConeAngle;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hLightCookie;
	bool m_bSphericalCookie;
};
