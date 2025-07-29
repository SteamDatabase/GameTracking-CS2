// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_MaintainEmitter : public CParticleFunctionEmitter
{
	// MPropertyFriendlyName = "count to maintain"
	CParticleCollectionFloatInput m_nParticlesToMaintain;
	// MPropertyFriendlyName = "emission start time"
	float32 m_flStartTime;
	// MPropertyFriendlyName = "emission duration"
	CParticleCollectionFloatInput m_flEmissionDuration;
	// MPropertyFriendlyName = "emission rate"
	float32 m_flEmissionRate;
	// MPropertyFriendlyName = "control point with snapshot data"
	int32 m_nSnapshotControlPoint;
	// MPropertyFriendlyName = "snapshot subset"
	// MPropertySuppressExpr = "m_nSnapshotControlPoint < 0"
	CUtlString m_strSnapshotSubset;
	// MPropertyFriendlyName = "group emission times for new particles"
	bool m_bEmitInstantaneously;
	// MPropertyFriendlyName = "perform final emit on stop"
	bool m_bFinalEmitOnStop;
	// MPropertyFriendlyName = "total count scale"
	CParticleCollectionFloatInput m_flScale;
};
