// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapCPtoVector : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "input control point number"
	int32 m_nCPInput;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "local space CP"
	int32 m_nLocalSpaceCP;
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
	// MPropertyFriendlyName = "emitter lifetime start time (seconds)"
	float32 m_flStartTime;
	// MPropertyFriendlyName = "emitter lifetime end time (seconds)"
	float32 m_flEndTime;
	// MPropertyFriendlyName = "interpolation scale"
	float32 m_flInterpRate;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "offset position"
	bool m_bOffset;
	// MPropertyFriendlyName = "accelerate position"
	bool m_bAccelerate;
};
