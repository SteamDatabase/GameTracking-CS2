// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_DecayMaintainCount : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "count to maintain"
	int32 m_nParticlesToMaintain;
	// MPropertyFriendlyName = "decay delay"
	float32 m_flDecayDelay;
	// MPropertyFriendlyName = "snapshot control point for count"
	int32 m_nSnapshotControlPoint;
	// MPropertyFriendlyName = "decay on lifespan"
	bool m_bLifespanDecay;
	// MPropertyFriendlyName = "total count scale"
	CParticleCollectionFloatInput m_flScale;
	// MPropertyFriendlyName = "kill newest instead of oldest"
	bool m_bKillNewest;
};
