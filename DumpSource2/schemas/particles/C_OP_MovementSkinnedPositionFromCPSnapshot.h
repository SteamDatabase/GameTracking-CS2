class C_OP_MovementSkinnedPositionFromCPSnapshot : public CParticleFunctionOperator
{
	int32 m_nSnapshotControlPointNumber;
	int32 m_nControlPointNumber;
	bool m_bRandom;
	int32 m_nRandomSeed;
	bool m_bSetNormal;
	bool m_bSetRadius;
	SnapshotIndexType_t m_nIndexType;
	CPerParticleFloatInput m_flReadIndex;
	CParticleCollectionFloatInput m_flIncrement;
	CParticleCollectionFloatInput m_nFullLoopIncrement;
	CParticleCollectionFloatInput m_nSnapShotStartPoint;
	CPerParticleFloatInput m_flInterpolation;
};
