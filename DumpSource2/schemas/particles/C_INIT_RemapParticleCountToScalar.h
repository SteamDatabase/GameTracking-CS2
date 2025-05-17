// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_RemapParticleCountToScalar : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "input minimum"
	int32 m_nInputMin;
	// MPropertyFriendlyName = "input maximum"
	int32 m_nInputMax;
	// MPropertyFriendlyName = "input scale control point"
	int32 m_nScaleControlPoint;
	// MPropertyFriendlyName = "input scale control point field"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nScaleControlPointField;
	// MPropertyFriendlyName = "output minimum"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "only active within specified input range"
	bool m_bActiveRange;
	// MPropertyFriendlyName = "invert input from total particle count"
	bool m_bInvert;
	// MPropertyFriendlyName = "wrap input"
	bool m_bWrap;
	// MPropertyFriendlyName = "remap bias"
	float32 m_flRemapBias;
};
