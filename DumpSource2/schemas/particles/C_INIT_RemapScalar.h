// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_RemapScalar : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "input field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldInput;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "input minimum"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "input maximum"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "emitter lifetime start time (seconds)"
	float32 m_flStartTime;
	// MPropertyFriendlyName = "emitter lifetime end time (seconds)"
	float32 m_flEndTime;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "only active within specified input range"
	bool m_bActiveRange;
	// MPropertyFriendlyName = "remap bias"
	float32 m_flRemapBias;
};
