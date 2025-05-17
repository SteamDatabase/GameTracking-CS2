// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_InitFromCPSnapshot : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "snapshot control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "field to read"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nAttributeToRead;
	// MPropertyFriendlyName = "field to write"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nAttributeToWrite;
	// MPropertyFriendlyName = "local space control point number"
	int32 m_nLocalSpaceCP;
	// MPropertyFriendlyName = "random order"
	bool m_bRandom;
	// MPropertyFriendlyName = "reverse order"
	bool m_bReverse;
	// MPropertyFriendlyName = "Snapshot increment amount"
	CParticleCollectionFloatInput m_nSnapShotIncrement;
	// MPropertyFriendlyName = "Manual Snapshot Index"
	CPerParticleFloatInput m_nManualSnapshotIndex;
	// MPropertyFriendlyName = "random seed"
	int32 m_nRandomSeed;
	// MPropertyFriendlyName = "local space angles"
	bool m_bLocalSpaceAngles;
};
