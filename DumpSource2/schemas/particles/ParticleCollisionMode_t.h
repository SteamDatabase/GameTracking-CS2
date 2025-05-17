enum ParticleCollisionMode_t : uint32_t
{
	// MPropertyFriendlyName = "Per-Particle Trace"
	COLLISION_MODE_PER_PARTICLE_TRACE = 3,
	// MPropertyFriendlyName = "Trace Caching"
	COLLISION_MODE_USE_NEAREST_TRACE = 2,
	// MPropertyFriendlyName = "Per-Frame Planeset"
	COLLISION_MODE_PER_FRAME_PLANESET = 1,
	// MPropertyFriendlyName = "Initial Trace Down"
	COLLISION_MODE_INITIAL_TRACE_DOWN = 0,
	// MPropertyFriendlyName = "Collision Disabled"
	COLLISION_MODE_DISABLED = -1,
};
