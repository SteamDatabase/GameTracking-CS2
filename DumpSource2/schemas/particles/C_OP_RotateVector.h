// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RotateVector : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "rotation axis min"
	// MVectorIsCoordinate
	Vector m_vecRotAxisMin;
	// MPropertyFriendlyName = "rotation axis max"
	// MVectorIsCoordinate
	Vector m_vecRotAxisMax;
	// MPropertyFriendlyName = "rotation rate min"
	float32 m_flRotRateMin;
	// MPropertyFriendlyName = "rotation rate max"
	float32 m_flRotRateMax;
	// MPropertyFriendlyName = "normalize output"
	bool m_bNormalize;
	// MPropertyFriendlyName = "per particle scale"
	CPerParticleFloatInput m_flScale;
};
