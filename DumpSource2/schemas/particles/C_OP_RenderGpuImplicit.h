// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderGpuImplicit : public CParticleFunctionRenderer
{
	// MPropertySortPriority = -1
	// MPropertyDescription = "Honors the per-particle radius (multiplied by radius scale) but is more expensive to render.  Some particles with large radii can make things much costlier"
	bool m_bUsePerParticleRadius;
	// MPropertyFriendlyName = "(optional) vertex buffer size (k)"
	// MPropertyAttributeRange = "0 1024"
	uint32 m_nVertexCountKb;
	// MPropertyFriendlyName = "(optional) index buffer size (k)"
	// MPropertyAttributeRange = "0 2048"
	uint32 m_nIndexCountKb;
	CParticleCollectionRendererFloatInput m_fGridSize;
	CParticleCollectionRendererFloatInput m_fRadiusScale;
	// MPropertyAttributeRange = ".1 .95"
	CParticleCollectionRendererFloatInput m_fIsosurfaceThreshold;
	// MPropertyFriendlyName = "scale CP (grid size/particle radius/threshold = x/y/z)"
	int32 m_nScaleCP;
	CStrongHandle< InfoForResourceTypeIMaterial2 > m_hMaterial;
};
