// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetUserEvent : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "input value"
	CPerParticleFloatInput m_flInput;
	// MPropertyFriendlyName = "rising edge value"
	CPerParticleFloatInput m_flRisingEdge;
	// MPropertyFriendlyName = "rising edge event type"
	EventTypeSelection_t m_nRisingEventType;
	// MPropertyFriendlyName = "falling edge value"
	CPerParticleFloatInput m_flFallingEdge;
	// MPropertyFriendlyName = "falling edge event type"
	EventTypeSelection_t m_nFallingEventType;
};
