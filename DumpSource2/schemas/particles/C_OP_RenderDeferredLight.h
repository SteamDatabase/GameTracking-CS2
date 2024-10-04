class C_OP_RenderDeferredLight : public CParticleFunctionRenderer
{
	bool m_bUseAlphaTestWindow;
	bool m_bUseTexture;
	float32 m_flRadiusScale;
	float32 m_flAlphaScale;
	ParticleAttributeIndex_t m_nAlpha2Field;
	CParticleCollectionVecInput m_vecColorScale;
	ParticleColorBlendType_t m_nColorBlendType;
	float32 m_flLightDistance;
	float32 m_flStartFalloff;
	float32 m_flDistanceFalloff;
	float32 m_flSpotFoV;
	ParticleAttributeIndex_t m_nAlphaTestPointField;
	ParticleAttributeIndex_t m_nAlphaTestRangeField;
	ParticleAttributeIndex_t m_nAlphaTestSharpnessField;
	CStrongHandle< InfoForResourceTypeCTextureBase > m_hTexture;
	int32 m_nHSVShiftControlPoint;
};
