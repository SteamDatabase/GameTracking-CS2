class C_INIT_CreateOnModelAtHeight : public CParticleFunctionInitializer
{
	bool m_bUseBones;
	bool m_bForceZ;
	int32 m_nControlPointNumber;
	int32 m_nHeightCP;
	bool m_bUseWaterHeight;
	CParticleCollectionFloatInput m_flDesiredHeight;
	CParticleCollectionVecInput m_vecHitBoxScale;
	CParticleCollectionVecInput m_vecDirectionBias;
	ParticleHitboxBiasType_t m_nBiasType;
	bool m_bLocalCoords;
	bool m_bPreferMovingBoxes;
	char[128] m_HitboxSetName;
	CParticleCollectionFloatInput m_flHitboxVelocityScale;
	CParticleCollectionFloatInput m_flMaxBoneVelocity;
};
