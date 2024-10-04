class C_OP_RenderMaterialProxy : public CParticleFunctionRenderer
{
	int32 m_nMaterialControlPoint;
	MaterialProxyType_t m_nProxyType;
	CUtlVector< MaterialVariable_t > m_MaterialVars;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hOverrideMaterial;
	CParticleCollectionFloatInput m_flMaterialOverrideEnabled;
	CParticleCollectionVecInput m_vecColorScale;
	CPerParticleFloatInput m_flAlpha;
	ParticleColorBlendType_t m_nColorBlendType;
};
