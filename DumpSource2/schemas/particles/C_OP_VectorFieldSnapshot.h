// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_VectorFieldSnapshot : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "snapshot control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "extra velocity field to write"
	// MPropertyAttributeChoiceName = "particlefield"
	ParticleAttributeIndex_t m_nAttributeToWrite;
	// MPropertyFriendlyName = "local space control point number"
	int32 m_nLocalSpaceCP;
	// MPropertyFriendlyName = "Interpolation"
	CPerParticleFloatInput m_flInterpolation;
	// MPropertyFriendlyName = "Component Scale"
	CPerParticleVecInput m_vecScale;
	// MPropertyFriendlyName = "Boundary Dampening"
	float32 m_flBoundaryDampening;
	// MPropertyFriendlyName = "Set Velocity"
	bool m_bSetVelocity;
	// MPropertyFriendlyName = "Lock to Surface"
	bool m_bLockToSurface;
	// MPropertyFriendlyName = "Vector Field Grid Spacing Override"
	float32 m_flGridSpacing;
};
