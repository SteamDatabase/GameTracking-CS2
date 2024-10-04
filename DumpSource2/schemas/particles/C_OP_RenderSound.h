class C_OP_RenderSound : public CParticleFunctionRenderer
{
	float32 m_flDurationScale;
	float32 m_flSndLvlScale;
	float32 m_flPitchScale;
	float32 m_flVolumeScale;
	ParticleAttributeIndex_t m_nSndLvlField;
	ParticleAttributeIndex_t m_nDurationField;
	ParticleAttributeIndex_t m_nPitchField;
	ParticleAttributeIndex_t m_nVolumeField;
	int32 m_nChannel;
	int32 m_nCPReference;
	char[256] m_pszSoundName;
	bool m_bSuppressStopSoundEvent;
};
