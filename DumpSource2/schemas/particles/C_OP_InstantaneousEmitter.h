class C_OP_InstantaneousEmitter : public CParticleFunctionEmitter
{
	CParticleCollectionFloatInput m_nParticlesToEmit;
	CParticleCollectionFloatInput m_flStartTime;
	float32 m_flInitFromKilledParentParticles;
	EventTypeSelection_t m_nEventType;
	CParticleCollectionFloatInput m_flParentParticleScale;
	int32 m_nMaxEmittedPerFrame;
	int32 m_nSnapshotControlPoint;
};
