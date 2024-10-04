class C_OP_SetUserEvent : public CParticleFunctionOperator
{
	CPerParticleFloatInput m_flInput;
	CPerParticleFloatInput m_flRisingEdge;
	EventTypeSelection_t m_nRisingEventType;
	CPerParticleFloatInput m_flFallingEdge;
	EventTypeSelection_t m_nFallingEventType;
};
