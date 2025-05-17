enum EventTypeSelection_t : uint32_t
{
	// MPropertyFriendlyName = "None"
	PARTICLE_EVENT_TYPE_MASK_NONE = 0,
	// MPropertyFriendlyName = "Spawned"
	PARTICLE_EVENT_TYPE_MASK_SPAWNED = 1,
	// MPropertyFriendlyName = "Killed"
	PARTICLE_EVENT_TYPE_MASK_KILLED = 2,
	// MPropertyFriendlyName = "Collision"
	PARTICLE_EVENT_TYPE_MASK_COLLISION = 4,
	// MPropertyFriendlyName = "First Collision"
	PARTICLE_EVENT_TYPE_MASK_FIRST_COLLISION = 8,
	// MPropertyFriendlyName = "Stopped on Collision"
	PARTICLE_EVENT_TYPE_MASK_COLLISION_STOPPED = 16,
	// MPropertyFriendlyName = "Killed on Collision"
	PARTICLE_EVENT_TYPE_MASK_KILLED_ON_COLLISION = 32,
	// MPropertyFriendlyName = "User Event 1"
	PARTICLE_EVENT_TYPE_MASK_USER_1 = 64,
	// MPropertyFriendlyName = "User Event 2"
	PARTICLE_EVENT_TYPE_MASK_USER_2 = 128,
	// MPropertyFriendlyName = "User Event 3"
	PARTICLE_EVENT_TYPE_MASK_USER_3 = 256,
	// MPropertyFriendlyName = "User Event 4"
	PARTICLE_EVENT_TYPE_MASK_USER_4 = 512,
};
