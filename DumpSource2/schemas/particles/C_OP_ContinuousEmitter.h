class C_OP_ContinuousEmitter : public CParticleFunctionEmitter
{
	CParticleCollectionFloatInput m_flEmissionDuration;
	CParticleCollectionFloatInput m_flStartTime;
	CParticleCollectionFloatInput m_flEmitRate;
	float32 m_flEmissionScale;
	float32 m_flScalePerParentParticle;
	bool m_bInitFromKilledParentParticles;
	EventTypeSelection_t m_nEventType;
	int32 m_nSnapshotControlPoint;
	int32 m_nLimitPerUpdate;
	bool m_bForceEmitOnFirstUpdate;
	bool m_bForceEmitOnLastUpdate;
};
