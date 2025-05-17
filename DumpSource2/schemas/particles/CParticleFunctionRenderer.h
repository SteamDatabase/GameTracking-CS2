// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CParticleFunctionRenderer : public CParticleFunction
{
	// MPropertySortPriority = -1
	CParticleVisibilityInputs VisibilityInputs;
	// MPropertyStartGroup = "Rendering filter"
	// MPropertyFriendlyName = "I cannot be refracted through refracting objects like water"
	// MPropertySortPriority = -1
	bool m_bCannotBeRefracted;
	// MPropertyFriendlyName = "Skip rendering on mobile"
	// MPropertySortPriority = -1
	bool m_bSkipRenderingOnMobile;
};
