enum ParticleParentSetMode_t : uint32_t
{
	// MPropertyFriendlyName = "Set Self and Children"
	PARTICLE_SET_PARENT_NO = 0,
	// MPropertyFriendlyName = "Set Immediate Parent, Self, and Children"
	PARTICLE_SET_PARENT_IMMEDIATE = 1,
	// MPropertyFriendlyName = "Set Root of Particle System Downward"
	PARTICLE_SET_PARENT_ROOT = 2,
};
