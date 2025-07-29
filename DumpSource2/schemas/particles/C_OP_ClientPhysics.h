// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ClientPhysics : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "client physics type"
	// MPropertyAttributeEditor = "VDataChoice( scripts/misc.vdata!generic_physics_particle_spawner )"
	CUtlString m_strPhysicsType;
	// MPropertyFriendlyName = "start all physics asleep"
	bool m_bStartAsleep;
	// MPropertyFriendlyName = "Player Wake Radius"
	CParticleCollectionFloatInput m_flPlayerWakeRadius;
	// MPropertyFriendlyName = "Vehicle Wake Radius"
	CParticleCollectionFloatInput m_flVehicleWakeRadius;
	// MPropertyFriendlyName = "use high quality simulation"
	bool m_bUseHighQualitySimulation;
	// MPropertyFriendlyName = "max particle count"
	int32 m_nMaxParticleCount;
	// MPropertyFriendlyName = "prevent spawning in exclusion volumes"
	// MPropertySuppressExpr = "m_bKillParticles == true"
	bool m_bRespectExclusionVolumes;
	// MPropertyFriendlyName = "kill physics particles"
	bool m_bKillParticles;
	// MPropertyFriendlyName = "delete physics sim when stopped"
	// MPropertySuppressExpr = "m_bKillParticles == false"
	bool m_bDeleteSim;
	// MPropertyFriendlyName = "control point (for finding nearest sim)"
	// MPropertySuppressExpr = "m_bKillParticles == true"
	int32 m_nControlPoint;
	// MPropertyFriendlyName = "specific sim id"
	// MPropertySuppressExpr = "m_bKillParticles == true"
	int32 m_nForcedSimId;
	// MPropertyFriendlyName = "tint blend (color vs prop group gradient)"
	ParticleColorBlendType_t m_nColorBlendType;
	// MPropertyFriendlyName = "forced status effect flags"
	ParticleAttrBoxFlags_t m_nForcedStatusEffects;
};
