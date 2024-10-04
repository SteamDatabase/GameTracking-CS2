class C_OP_RenderCables : public CParticleFunctionRenderer
{
	CParticleCollectionFloatInput m_flRadiusScale;
	CParticleCollectionFloatInput m_flAlphaScale;
	CParticleCollectionVecInput m_vecColorScale;
	ParticleColorBlendType_t m_nColorBlendType;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterial;
	TextureRepetitionMode_t m_nTextureRepetitionMode;
	CParticleCollectionFloatInput m_flTextureRepeatsPerSegment;
	CParticleCollectionFloatInput m_flTextureRepeatsCircumference;
	CParticleCollectionFloatInput m_flColorMapOffsetV;
	CParticleCollectionFloatInput m_flColorMapOffsetU;
	CParticleCollectionFloatInput m_flNormalMapOffsetV;
	CParticleCollectionFloatInput m_flNormalMapOffsetU;
	bool m_bDrawCableCaps;
	float32 m_flCapRoundness;
	float32 m_flCapOffsetAmount;
	float32 m_flTessScale;
	int32 m_nMinTesselation;
	int32 m_nMaxTesselation;
	int32 m_nRoundness;
	CParticleTransformInput m_LightingTransform;
	CUtlVector< FloatInputMaterialVariable_t > m_MaterialFloatVars;
	CUtlVector< VecInputMaterialVariable_t > m_MaterialVecVars;
};
