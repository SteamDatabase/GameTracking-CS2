class C_OP_DecayMaintainCount : public CParticleFunctionOperator
{
	int32 m_nParticlesToMaintain;
	float32 m_flDecayDelay;
	int32 m_nSnapshotControlPoint;
	bool m_bLifespanDecay;
	CParticleCollectionFloatInput m_flScale;
	bool m_bKillNewest;
};
