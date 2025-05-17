// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SDFConstraint : public CParticleFunctionConstraint
{
	// MPropertyFriendlyName = "min dist to sdf"
	CParticleCollectionFloatInput m_flMinDist;
	// MPropertyFriendlyName = "max dist to sdf"
	CParticleCollectionFloatInput m_flMaxDist;
	// MPropertyFriendlyName = "Max # of iterations"
	int32 m_nMaxIterations;
};
