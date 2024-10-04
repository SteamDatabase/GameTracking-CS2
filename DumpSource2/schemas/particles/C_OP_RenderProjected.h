class C_OP_RenderProjected : public CParticleFunctionRenderer
{
	bool m_bProjectCharacter;
	bool m_bProjectWorld;
	bool m_bProjectWater;
	bool m_bFlipHorizontal;
	bool m_bEnableProjectedDepthControls;
	float32 m_flMinProjectionDepth;
	float32 m_flMaxProjectionDepth;
	CUtlVector< RenderProjectedMaterial_t > m_vecProjectedMaterials;
	CPerParticleFloatInput m_flMaterialSelection;
	float32 m_flAnimationTimeScale;
	bool m_bOrientToNormal;
	CUtlVector< MaterialVariable_t > m_MaterialVars;
	CParticleCollectionFloatInput m_flRadiusScale;
	CParticleCollectionFloatInput m_flAlphaScale;
	CParticleCollectionFloatInput m_flRollScale;
	ParticleAttributeIndex_t m_nAlpha2Field;
	CParticleCollectionVecInput m_vecColorScale;
	ParticleColorBlendType_t m_nColorBlendType;
};
