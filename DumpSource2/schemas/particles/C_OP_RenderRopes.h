// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderRopes : public CBaseRendererSource2
{
	// MPropertyStartGroup = "Screenspace Fading and culling"
	// MPropertyFriendlyName = "enable fading and clamping"
	// MPropertySortPriority = 1000
	bool m_bEnableFadingAndClamping;
	// MPropertyFriendlyName = "minimum visual screen-size"
	// MPropertySuppressExpr = "!m_bEnableFadingAndClamping"
	float32 m_flMinSize;
	// MPropertyFriendlyName = "maximum visual screen-size"
	// MPropertySuppressExpr = "!m_bEnableFadingAndClamping"
	float32 m_flMaxSize;
	// MPropertyFriendlyName = "start fade screen-size"
	// MPropertySuppressExpr = "!m_bEnableFadingAndClamping"
	float32 m_flStartFadeSize;
	// MPropertyFriendlyName = "end fade and cull screen-size"
	// MPropertySuppressExpr = "!m_bEnableFadingAndClamping"
	float32 m_flEndFadeSize;
	// MPropertyFriendlyName = "start fade dot product of normal vs view"
	// MPropertySortPriority = 1000
	float32 m_flStartFadeDot;
	// MPropertyFriendlyName = "end fade dot product of normal vs view"
	// MPropertySortPriority = 1000
	float32 m_flEndFadeDot;
	// MPropertyStartGroup = "Rope Tesselation"
	// MPropertyFriendlyName = "amount to taper the width of the trail end by"
	float32 m_flRadiusTaper;
	// MPropertyFriendlyName = "minium number of quads per render segment"
	// MPropertySortPriority = 850
	int32 m_nMinTesselation;
	// MPropertyFriendlyName = "maximum number of quads per render segment"
	int32 m_nMaxTesselation;
	// MPropertyFriendlyName = "tesselation resolution scale factor"
	float32 m_flTessScale;
	// MPropertyStartGroup = "+Rope Global UV Controls"
	// MPropertyFriendlyName = "global texture V World Size"
	// MPropertySortPriority = 800
	CParticleCollectionRendererFloatInput m_flTextureVWorldSize;
	// MPropertyFriendlyName = "global texture V Scroll Rate"
	CParticleCollectionRendererFloatInput m_flTextureVScrollRate;
	// MPropertyFriendlyName = "global texture V Offset"
	CParticleCollectionRendererFloatInput m_flTextureVOffset;
	// MPropertyFriendlyName = "global texture V Params CP"
	int32 m_nTextureVParamsCP;
	// MPropertyFriendlyName = "Clamp Non-Sheet texture V coords"
	bool m_bClampV;
	// MPropertyStartGroup = "Rope Global UV Controls/CP Scaling"
	// MPropertyFriendlyName = "scale CP start"
	int32 m_nScaleCP1;
	// MPropertyFriendlyName = "scale CP end"
	int32 m_nScaleCP2;
	// MPropertyFriendlyName = "scale V world size by CP distance"
	float32 m_flScaleVSizeByControlPointDistance;
	// MPropertyFriendlyName = "scale V scroll rate by CP distance"
	float32 m_flScaleVScrollByControlPointDistance;
	// MPropertyFriendlyName = "scale V offset by CP distance"
	float32 m_flScaleVOffsetByControlPointDistance;
	// MPropertyStartGroup = "Rope Global UV Controls"
	// MPropertyFriendlyName = "Use scalar attribute for texture coordinate"
	bool m_bUseScalarForTextureCoordinate;
	// MPropertyFriendlyName = "scalar to use for texture coordinate"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	// MPropertySuppressExpr = "!m_bUseScalarForTextureCoordinate"
	ParticleAttributeIndex_t m_nScalarFieldForTextureCoordinate;
	// MPropertyFriendlyName = "scale value to map attribute to texture coordinate"
	// MPropertySuppressExpr = "!m_bUseScalarForTextureCoordinate"
	float32 m_flScalarAttributeTextureCoordScale;
	// MPropertyStartGroup = "Rope Order Controls"
	// MPropertyFriendlyName = "reverse point order"
	// MPropertySortPriority = 800
	bool m_bReverseOrder;
	// MPropertyFriendlyName = "Closed loop"
	bool m_bClosedLoop;
	// MPropertyStartGroup = "Orientation"
	// MPropertyFriendlyName = "orientation_type"
	// MPropertySortPriority = 750
	ParticleOrientationChoiceList_t m_nOrientationType;
	// MPropertyFriendlyName = "attribute to use for normal"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	// MPropertySortPriority = 750
	// MPropertySuppressExpr = "m_nOrientationType != PARTICLE_ORIENTATION_ALIGN_TO_PARTICLE_NORMAL && m_nOrientationType != PARTICLE_ORIENTATION_SCREENALIGN_TO_PARTICLE_NORMAL"
	ParticleAttributeIndex_t m_nVectorFieldForOrientation;
	// MPropertyStartGroup = "Material"
	// MPropertyFriendlyName = "draw as opaque"
	bool m_bDrawAsOpaque;
	// MPropertyStartGroup = "Orientation"
	// MPropertyFriendlyName = "generate normals for cylinder"
	bool m_bGenerateNormals;
};
