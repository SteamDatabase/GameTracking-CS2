// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_LightningSnapshotGenerator : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "snapshot control point number"
	int32 m_nCPSnapshot;
	// MPropertyFriendlyName = "start control point number"
	int32 m_nCPStartPnt;
	// MPropertyFriendlyName = "end control point number"
	int32 m_nCPEndPnt;
	// MPropertyFriendlyName = "Recursion Depth"
	CParticleCollectionFloatInput m_flSegments;
	// MPropertyFriendlyName = "Offset"
	CParticleCollectionFloatInput m_flOffset;
	// MPropertyFriendlyName = "Offset Decay"
	CParticleCollectionFloatInput m_flOffsetDecay;
	// MPropertyFriendlyName = "Recalculation Rate"
	CParticleCollectionFloatInput m_flRecalcRate;
	// MPropertyFriendlyName = "UV Scale"
	CParticleCollectionFloatInput m_flUVScale;
	// MPropertyFriendlyName = "UV Offset"
	CParticleCollectionFloatInput m_flUVOffset;
	// MPropertyFriendlyName = "Branch Split Rate"
	CParticleCollectionFloatInput m_flSplitRate;
	// MPropertyFriendlyName = "Branch Twist"
	CParticleCollectionFloatInput m_flBranchTwist;
	// MPropertyFriendlyName = "Branch Behavior"
	ParticleLightnintBranchBehavior_t m_nBranchBehavior;
	// MPropertyFriendlyName = "Start Radius"
	CParticleCollectionFloatInput m_flRadiusStart;
	// MPropertyFriendlyName = "End Radius"
	CParticleCollectionFloatInput m_flRadiusEnd;
	// MPropertyFriendlyName = "Dedicated Particle Pool Count"
	CParticleCollectionFloatInput m_flDedicatedPool;
};
