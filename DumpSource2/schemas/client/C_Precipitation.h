class C_Precipitation : public C_BaseTrigger
{
	float32 m_flDensity;
	float32 m_flParticleInnerDist;
	char* m_pParticleDef;
	TimedEvent[1] m_tParticlePrecipTraceTimer;
	bool[1] m_bActiveParticlePrecipEmitter;
	bool m_bParticlePrecipInitialized;
	bool m_bHasSimulatedSinceLastSceneObjectUpdate;
	int32 m_nAvailableSheetSequencesMaxIndex;
}
