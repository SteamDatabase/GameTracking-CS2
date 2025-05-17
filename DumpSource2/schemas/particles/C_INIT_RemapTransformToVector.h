// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_RemapTransformToVector : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "input minimum"
	// MVectorIsSometimesCoordinate = "m_nFieldOutput"
	Vector m_vInputMin;
	// MPropertyFriendlyName = "input maximum"
	// MVectorIsSometimesCoordinate = "m_nFieldOutput"
	Vector m_vInputMax;
	// MPropertyFriendlyName = "output minimum"
	// MVectorIsSometimesCoordinate = "m_nFieldOutput"
	Vector m_vOutputMin;
	// MPropertyFriendlyName = "output maximum"
	// MVectorIsSometimesCoordinate = "m_nFieldOutput"
	Vector m_vOutputMax;
	// MPropertyFriendlyName = "transform input"
	CParticleTransformInput m_TransformInput;
	// MPropertyFriendlyName = "local space transform"
	// MParticleInputOptional
	CParticleTransformInput m_LocalSpaceTransform;
	// MPropertyFriendlyName = "emitter lifetime start time (seconds)"
	float32 m_flStartTime;
	// MPropertyFriendlyName = "emitter lifetime end time (seconds)"
	float32 m_flEndTime;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "offset position"
	bool m_bOffset;
	// MPropertyFriendlyName = "accelerate position"
	bool m_bAccelerate;
	// MPropertyFriendlyName = "remap bias"
	float32 m_flRemapBias;
};
