class C_Precipitation : public C_BaseTrigger
{
	// MNotSaved
	float32 m_flDensity;
	// MNotSaved
	float32 m_flParticleInnerDist;
	// MNotSaved
	char* m_pParticleDef;
	// MNotSaved
	TimedEvent[1] m_tParticlePrecipTraceTimer;
	// MNotSaved
	bool[1] m_bActiveParticlePrecipEmitter;
	// MNotSaved
	bool m_bParticlePrecipInitialized;
	// MNotSaved
	bool m_bHasSimulatedSinceLastSceneObjectUpdate;
	// MNotSaved
	int32 m_nAvailableSheetSequencesMaxIndex;
};
