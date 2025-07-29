// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetFromCPSnapshot : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "snapshot control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "snapshot subset"
	// MPropertySuppressExpr = "m_nControlPointNumber < 0"
	CUtlString m_strSnapshotSubset;
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
	// MPropertyFriendlyName = "random seed"
	int32 m_nRandomSeed;
	// MPropertyFriendlyName = "Snapshot start point"
	CParticleCollectionFloatInput m_nSnapShotStartPoint;
	// MPropertyFriendlyName = "Snapshot increment amount"
	CParticleCollectionFloatInput m_nSnapShotIncrement;
	// MPropertyFriendlyName = "Interpolation"
	CPerParticleFloatInput m_flInterpolation;
	// MPropertyFriendlyName = "Sub-Sample Between Input Points"
	bool m_bSubSample;
	// MPropertyFriendlyName = "Position also sets Previous Position"
	bool m_bPrev;
};
