enum ParticleCollisionMask_t : uint64_t
{
	// MPropertyFriendlyName = "Mask All"
	PARTICLE_MASK_ALL = -1,
	// MPropertyFriendlyName = "Mask Solid"
	PARTICLE_MASK_SOLID = 798721,
	// MPropertyFriendlyName = "Mask Water"
	PARTICLE_MASK_WATER = 98304,
	// MPropertyFriendlyName = "Mask Solid and Water"
	PARTICLE_MASK_SOLID_WATER = 897025,
	// MPropertyFriendlyName = "Mask Shot (raycasted bullets)"
	PARTICLE_MASK_SHOT = 1839107,
	// MPropertyFriendlyName = "Mask Shot Brush Only"
	PARTICLE_MASK_SHOT_BRUSHONLY = 1052673,
	// MPropertyFriendlyName = "Mask Shot Hull (non-raycasted)"
	PARTICLE_MASK_SHOT_HULL = 1847297,
	// MPropertyFriendlyName = "Mask Opaque"
	PARTICLE_MASK_OPAQUE = 128,
	// MPropertyFriendlyName = "Mask Player Solid"
	PARTICLE_MASK_DEFAULTPLAYERSOLID = 798737,
	// MPropertyFriendlyName = "Mask NPC Solid"
	PARTICLE_MASK_NPCSOLID = 798753,
};
