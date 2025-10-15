enum ParticleLightingQuality_t : uint32_t
{
	// MPropertyFriendlyName = "Per-Particle Lighting"
	PARTICLE_LIGHTING_PER_PARTICLE = 0,
	// MPropertyFriendlyName = "Per-Vertex Lighting"
	PARTICLE_LIGHTING_PER_VERTEX = 1,
	// MPropertyFriendlyName = "Per-Pixel Lighting"
	PARTICLE_LIGHTING_PER_PIXEL = -1,
	// MPropertyFriendlyName = "Override Position"
	PARTICLE_LIGHTING_OVERRIDE_POSITION = 2,
	// MPropertyFriendlyName = "Override Color"
	PARTICLE_LIGHTING_OVERRIDE_COLOR = 3,
	// MPropertyFriendlyName = "Add Extra Lighting Color"
	PARTICLE_LIGHTING_ADD_EXTRA_LIGHT = 4,
};
