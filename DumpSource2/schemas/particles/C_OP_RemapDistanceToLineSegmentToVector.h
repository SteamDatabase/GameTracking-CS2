// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapDistanceToLineSegmentToVector : public C_OP_RemapDistanceToLineSegmentBase
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "output value at min distance"
	Vector m_vMinOutputValue;
	// MPropertyFriendlyName = "output value at max distance"
	Vector m_vMaxOutputValue;
};
