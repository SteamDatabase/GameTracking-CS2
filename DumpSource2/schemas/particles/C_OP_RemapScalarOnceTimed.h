// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapScalarOnceTimed : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "remap time proportional"
	bool m_bProportional;
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
	// MPropertyFriendlyName = "remap time"
	float32 m_flRemapTime;
};
