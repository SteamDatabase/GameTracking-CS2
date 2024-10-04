class C_INIT_InitFromCPSnapshot : public CParticleFunctionInitializer
{
	int32 m_nControlPointNumber;
	ParticleAttributeIndex_t m_nAttributeToRead;
	ParticleAttributeIndex_t m_nAttributeToWrite;
	int32 m_nLocalSpaceCP;
	bool m_bRandom;
	bool m_bReverse;
	CParticleCollectionFloatInput m_nSnapShotIncrement;
	CPerParticleFloatInput m_nManualSnapshotIndex;
	int32 m_nRandomSeed;
	bool m_bLocalSpaceAngles;
};
