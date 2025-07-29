// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_InstantaneousEmitter : public CParticleFunctionEmitter
{
	// MPropertyFriendlyName = "num to emit"
	// MPropertyAttributeRange = "1 1000"
	CParticleCollectionFloatInput m_nParticlesToEmit;
	// MPropertyFriendlyName = "emission start time"
	CParticleCollectionFloatInput m_flStartTime;
	// MPropertyFriendlyName = "emission scale from parent particle events"
	float32 m_flInitFromKilledParentParticles;
	// MPropertyFriendlyName = "emission parent particle event type"
	// MPropertySuppressExpr = "m_flInitFromKilledParentParticles == 0"
	EventTypeSelection_t m_nEventType;
	// MPropertyFriendlyName = "emission scale from parent particle count"
	CParticleCollectionFloatInput m_flParentParticleScale;
	// MPropertyFriendlyName = "maximum emission per frame"
	int32 m_nMaxEmittedPerFrame;
	// MPropertyFriendlyName = "control point with snapshot data"
	int32 m_nSnapshotControlPoint;
	// MPropertyFriendlyName = "snapshot subset"
	// MPropertySuppressExpr = "m_nSnapshotControlPoint < 0"
	CUtlString m_strSnapshotSubset;
};
