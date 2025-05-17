// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapAverageScalarValuetoCP : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "output control point"
	int32 m_nOutControlPointNumber;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nOutVectorField;
	// MPropertyFriendlyName = "scalar field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nField;
	// MPropertyFriendlyName = "input volume minimum"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "input volume maximum"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	float32 m_flOutputMax;
};
