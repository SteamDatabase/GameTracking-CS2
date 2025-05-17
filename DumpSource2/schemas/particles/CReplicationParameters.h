// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CReplicationParameters
{
	// MPropertyFriendlyName = "Replication mode"
	ParticleReplicationMode_t m_nReplicationMode;
	// MPropertyFriendlyName = "Scale child particle radius based on parent radius"
	bool m_bScaleChildParticleRadii;
	// MPropertyFriendlyName = "Minimum random scale for radius"
	CParticleCollectionFloatInput m_flMinRandomRadiusScale;
	// MPropertyFriendlyName = "Maximum random scale for radius"
	CParticleCollectionFloatInput m_flMaxRandomRadiusScale;
	// MPropertyFriendlyName = "min random displacement for child particles"
	CParticleCollectionVecInput m_vMinRandomDisplacement;
	// MPropertyFriendlyName = "max random displacement for child particles"
	CParticleCollectionVecInput m_vMaxRandomDisplacement;
	// MPropertyFriendlyName = "Modelling scale"
	CParticleCollectionFloatInput m_flModellingScale;
};
