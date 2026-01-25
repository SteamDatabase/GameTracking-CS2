class CFuncTimescale : public CBaseEntity
{
	float32 m_flDesiredTimescale;
	float32 m_flAcceleration;
	float32 m_flMinBlendRate;
	float32 m_flBlendDeltaMultiplier;
	// MNotSaved
	bool m_isStarted;
};
