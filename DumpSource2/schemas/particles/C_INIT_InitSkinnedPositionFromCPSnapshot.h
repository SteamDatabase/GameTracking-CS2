class C_INIT_InitSkinnedPositionFromCPSnapshot : public CParticleFunctionInitializer
{
	int32 m_nSnapshotControlPointNumber;
	int32 m_nControlPointNumber;
	bool m_bRandom;
	int32 m_nRandomSeed;
	bool m_bRigid;
	bool m_bSetNormal;
	bool m_bIgnoreDt;
	float32 m_flMinNormalVelocity;
	float32 m_flMaxNormalVelocity;
	SnapshotIndexType_t m_nIndexType;
	CPerParticleFloatInput m_flReadIndex;
	float32 m_flIncrement;
	int32 m_nFullLoopIncrement;
	int32 m_nSnapShotStartPoint;
	float32 m_flBoneVelocity;
	float32 m_flBoneVelocityMax;
	bool m_bCopyColor;
	bool m_bCopyAlpha;
	bool m_bSetRadius;
};
