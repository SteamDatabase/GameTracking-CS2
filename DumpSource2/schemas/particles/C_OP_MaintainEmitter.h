class C_OP_MaintainEmitter : public CParticleFunctionEmitter
{
	CParticleCollectionFloatInput m_nParticlesToMaintain;
	float32 m_flStartTime;
	CParticleCollectionFloatInput m_flEmissionDuration;
	float32 m_flEmissionRate;
	int32 m_nSnapshotControlPoint;
	bool m_bEmitInstantaneously;
	bool m_bFinalEmitOnStop;
	CParticleCollectionFloatInput m_flScale;
};
