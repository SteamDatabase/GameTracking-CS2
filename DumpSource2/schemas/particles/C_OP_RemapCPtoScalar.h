// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapCPtoScalar : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "input control point number"
	int32 m_nCPInput;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "input field 0-2 X/Y/Z"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nField;
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
	// MPropertyFriendlyName = "interpolation scale"
	float32 m_flInterpRate;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
};
