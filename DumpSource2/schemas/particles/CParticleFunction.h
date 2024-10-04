class CParticleFunction
{
	CParticleCollectionFloatInput m_flOpStrength;
	ParticleEndcapMode_t m_nOpEndCapState;
	float32 m_flOpStartFadeInTime;
	float32 m_flOpEndFadeInTime;
	float32 m_flOpStartFadeOutTime;
	float32 m_flOpEndFadeOutTime;
	float32 m_flOpFadeOscillatePeriod;
	bool m_bNormalizeToStopTime;
	float32 m_flOpTimeOffsetMin;
	float32 m_flOpTimeOffsetMax;
	int32 m_nOpTimeOffsetSeed;
	int32 m_nOpTimeScaleSeed;
	float32 m_flOpTimeScaleMin;
	float32 m_flOpTimeScaleMax;
	bool m_bDisableOperator;
	CUtlString m_Notes;
};
