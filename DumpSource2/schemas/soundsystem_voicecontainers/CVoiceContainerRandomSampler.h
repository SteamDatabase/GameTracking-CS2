class CVoiceContainerRandomSampler : public CVoiceContainerBase
{
	float32 m_flAmplitude;
	float32 m_flAmplitudeJitter;
	float32 m_flTimeJitter;
	float32 m_flMaxLength;
	int32 m_nNumDelayVariations;
	CUtlVector< CStrongHandle< InfoForResourceTypeCVoiceContainerBase > > m_grainResources;
};
