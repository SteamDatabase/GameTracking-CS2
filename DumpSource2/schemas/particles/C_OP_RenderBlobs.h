class C_OP_RenderBlobs : public CParticleFunctionRenderer
{
	CParticleCollectionRendererFloatInput m_cubeWidth;
	CParticleCollectionRendererFloatInput m_cutoffRadius;
	CParticleCollectionRendererFloatInput m_renderRadius;
	uint32 m_nVertexCountKb;
	uint32 m_nIndexCountKb;
	int32 m_nScaleCP;
	CUtlVector< MaterialVariable_t > m_MaterialVars;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterial;
};
