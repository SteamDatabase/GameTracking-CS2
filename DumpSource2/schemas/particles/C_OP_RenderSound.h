// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderSound : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "duration scale"
	float32 m_flDurationScale;
	// MPropertyFriendlyName = "decibel level scale"
	float32 m_flSndLvlScale;
	// MPropertyFriendlyName = "pitch scale"
	float32 m_flPitchScale;
	// MPropertyFriendlyName = "volume scale"
	float32 m_flVolumeScale;
	// MPropertyFriendlyName = "decibel level field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nSndLvlField;
	// MPropertyFriendlyName = "duration field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nDurationField;
	// MPropertyFriendlyName = "pitch field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nPitchField;
	// MPropertyFriendlyName = "volume field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nVolumeField;
	// MPropertyFriendlyName = "sound channel"
	// MPropertyAttributeChoiceName = "sound_channel"
	int32 m_nChannel;
	// MPropertyFriendlyName = "sound control point number"
	int32 m_nCPReference;
	// MPropertyFriendlyName = "sound"
	// MPropertyAttributeEditor = "SoundPicker()"
	char[256] m_pszSoundName;
	// MPropertyFriendlyName = "suppress stop event"
	bool m_bSuppressStopSoundEvent;
};
