class C_OP_ClientPhysics : public CParticleFunctionRenderer
{
	CUtlString m_strPhysicsType;
	bool m_bStartAsleep;
	CParticleCollectionFloatInput m_flPlayerWakeRadius;
	CParticleCollectionFloatInput m_flVehicleWakeRadius;
	bool m_bUseHighQualitySimulation;
	int32 m_nMaxParticleCount;
	bool m_bRespectExclusionVolumes;
	bool m_bKillParticles;
	bool m_bDeleteSim;
	int32 m_nControlPoint;
	ParticleColorBlendType_t m_nColorBlendType;
};
