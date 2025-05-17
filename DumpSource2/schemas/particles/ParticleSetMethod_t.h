enum ParticleSetMethod_t : uint32_t
{
	// MPropertyFriendlyName = "Set Value"
	PARTICLE_SET_REPLACE_VALUE = 0,
	// MPropertyFriendlyName = "Scale Initial Value"
	PARTICLE_SET_SCALE_INITIAL_VALUE = 1,
	// MPropertyFriendlyName = "Add to Initial Value"
	PARTICLE_SET_ADD_TO_INITIAL_VALUE = 2,
	// MPropertyFriendlyName = "Ramp Current Value at Input Rate Per Second"
	PARTICLE_SET_RAMP_CURRENT_VALUE = 3,
	// MPropertyFriendlyName = "Scale Current Value Raw"
	PARTICLE_SET_SCALE_CURRENT_VALUE = 4,
	// MPropertyFriendlyName = "Add to Current Value Raw"
	PARTICLE_SET_ADD_TO_CURRENT_VALUE = 5,
};
