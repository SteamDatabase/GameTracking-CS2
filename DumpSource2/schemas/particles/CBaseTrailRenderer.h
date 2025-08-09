// MGetKV3ClassDefaults = Could not parse KV3 Defaults
class CBaseTrailRenderer : public CBaseRendererSource2
{
	// MPropertyStartGroup = "Orientation"
	// MPropertyFriendlyName = "orientation type"
	// MPropertySortPriority = 750
	ParticleOrientationChoiceList_t m_nOrientationType;
	// MPropertyFriendlyName = "orientation control point"
	// MPropertySortPriority = 750
	// MPropertySuppressExpr = "m_nOrientationType != PARTICLE_ORIENTATION_ALIGN_TO_PARTICLE_NORMAL && m_nOrientationType != PARTICLE_ORIENTATION_SCREENALIGN_TO_PARTICLE_NORMAL"
	int32 m_nOrientationControlPoint;
	// MPropertyStartGroup = "Screenspace Fading and culling"
	// MPropertyFriendlyName = "minimum visual screen-size"
	// MPropertySortPriority = 900
	float32 m_flMinSize;
	// MPropertyFriendlyName = "maximum visual screen-size"
	// MPropertySortPriority = 900
	float32 m_flMaxSize;
	// MPropertyFriendlyName = "start fade screen-size"
	// MPropertySortPriority = 900
	CParticleCollectionRendererFloatInput m_flStartFadeSize;
	// MPropertyFriendlyName = "end fade and cull screen-size"
	// MPropertySortPriority = 900
	CParticleCollectionRendererFloatInput m_flEndFadeSize;
	// MPropertyStartGroup = "Trail UV Controls"
	// MPropertyFriendlyName = "Clamp Non-Sheet texture V coords"
	// MPropertySortPriority = 800
	bool m_bClampV;
};
