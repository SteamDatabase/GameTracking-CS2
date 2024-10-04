class C_OP_RenderVRHapticEvent : public CParticleFunctionRenderer
{
	ParticleVRHandChoiceList_t m_nHand;
	int32 m_nOutputHandCP;
	int32 m_nOutputField;
	CPerParticleFloatInput m_flAmplitude;
};
