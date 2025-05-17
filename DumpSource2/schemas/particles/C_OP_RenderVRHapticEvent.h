// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderVRHapticEvent : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "haptic hand"
	ParticleVRHandChoiceList_t m_nHand;
	// MPropertyFriendlyName = "hand control point number"
	int32 m_nOutputHandCP;
	// MPropertyFriendlyName = "cp field"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nOutputField;
	// MPropertyFriendlyName = "amplitude"
	CPerParticleFloatInput m_flAmplitude;
};
