// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ContinuousEmitter : public CParticleFunctionEmitter
{
	// MPropertyFriendlyName = "emission duration"
	CParticleCollectionFloatInput m_flEmissionDuration;
	// MPropertyFriendlyName = "emission start time"
	CParticleCollectionFloatInput m_flStartTime;
	// MPropertyFriendlyName = "emission rate"
	CParticleCollectionFloatInput m_flEmitRate;
	// MPropertyFriendlyName = "scale emission to used control points"
	// MParticleMaxVersion = 1
	float32 m_flEmissionScale;
	// MPropertyFriendlyName = "scale emission by parent particle count"
	float32 m_flScalePerParentParticle;
	// MPropertyFriendlyName = "emit particles for parent particle events"
	bool m_bInitFromKilledParentParticles;
	// MPropertyFriendlyName = "emission parent particle event type"
	// MPropertySuppressExpr = "m_bInitFromKilledParentParticles == false"
	EventTypeSelection_t m_nEventType;
	// MPropertyFriendlyName = "control point with snapshot data"
	int32 m_nSnapshotControlPoint;
	// MPropertyFriendlyName = "snapshot subset"
	// MPropertySuppressExpr = "m_nSnapshotControlPoint < 0"
	CUtlString m_strSnapshotSubset;
	// MPropertyFriendlyName = "limit per update"
	int32 m_nLimitPerUpdate;
	// MPropertyFriendlyName = "force emit on first update"
	bool m_bForceEmitOnFirstUpdate;
	// MPropertyFriendlyName = "force emit on last update"
	bool m_bForceEmitOnLastUpdate;
};
