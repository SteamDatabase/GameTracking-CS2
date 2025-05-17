// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderBlobs : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "cube width"
	CParticleCollectionRendererFloatInput m_cubeWidth;
	// MPropertyFriendlyName = "cutoff radius"
	CParticleCollectionRendererFloatInput m_cutoffRadius;
	// MPropertyFriendlyName = "render radius"
	CParticleCollectionRendererFloatInput m_renderRadius;
	// MPropertyFriendlyName = "(optional) vertex buffer size (k)"
	// MPropertyAttributeRange = "0 1024"
	uint32 m_nVertexCountKb;
	// MPropertyFriendlyName = "(optional) index buffer size (k)"
	// MPropertyAttributeRange = "0 1024"
	uint32 m_nIndexCountKb;
	// MPropertyFriendlyName = "scale CP (cube width/cutoff/render = x/y/z)"
	int32 m_nScaleCP;
	// MPropertyFriendlyName = "material variables"
	// MPropertyAutoExpandSelf
	// MPropertySortPriority = 600
	CUtlVector< MaterialVariable_t > m_MaterialVars;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterial;
};
