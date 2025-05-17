enum ParticlePinDistance_t : uint32_t
{
	// MPropertyFriendlyName = "Don't Break"
	PARTICLE_PIN_DISTANCE_NONE = -1,
	// MPropertyFriendlyName = "Distance to Neighboring Particle"
	PARTICLE_PIN_DISTANCE_NEIGHBOR = 0,
	// MPropertyFriendlyName = "Distance to Farthest Particle"
	PARTICLE_PIN_DISTANCE_FARTHEST = 1,
	// MPropertyFriendlyName = "Distance to First Particle"
	PARTICLE_PIN_DISTANCE_FIRST = 2,
	// MPropertyFriendlyName = "Distance to Last Particle"
	PARTICLE_PIN_DISTANCE_LAST = 3,
	// MPropertyFriendlyName = "Distance to Particle System Center"
	PARTICLE_PIN_DISTANCE_CENTER = 5,
	// MPropertyFriendlyName = "Distance to Control Point"
	PARTICLE_PIN_DISTANCE_CP = 6,
	// MPropertyFriendlyName = "Distance to Either of Two Control Points"
	PARTICLE_PIN_DISTANCE_CP_PAIR_EITHER = 7,
	// MPropertyFriendlyName = "Distance to Both of Two Control Points"
	PARTICLE_PIN_DISTANCE_CP_PAIR_BOTH = 8,
	// MPropertyFriendlyName = "Particle Speed"
	PARTICLE_PIN_SPEED = 9,
	// MPropertyFriendlyName = "Collection Age"
	PARTICLE_PIN_COLLECTION_AGE = 10,
	// MPropertyFriendlyName = "Break Value of >= 1"
	PARTICLE_PIN_FLOAT_VALUE = 11,
};
