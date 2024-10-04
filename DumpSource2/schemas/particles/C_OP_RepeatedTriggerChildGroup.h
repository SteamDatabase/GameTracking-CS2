class C_OP_RepeatedTriggerChildGroup : public CParticleFunctionPreEmission
{
	int32 m_nChildGroupID;
	CParticleCollectionFloatInput m_flClusterRefireTime;
	CParticleCollectionFloatInput m_flClusterSize;
	CParticleCollectionFloatInput m_flClusterCooldown;
	bool m_bLimitChildCount;
};
