// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ChladniWave : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "wave minimum"
	CPerParticleFloatInput m_flInputMin;
	// MPropertyFriendlyName = "wave maximum"
	CPerParticleFloatInput m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	CPerParticleFloatInput m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	CPerParticleFloatInput m_flOutputMax;
	// MPropertyFriendlyName = "wave length"
	CPerParticleVecInput m_vecWaveLength;
	// MPropertyFriendlyName = "harmonics"
	CPerParticleVecInput m_vecHarmonics;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "local space control point"
	int32 m_nLocalSpaceControlPoint;
	// MPropertyFriendlyName = "3D"
	bool m_b3D;
};
