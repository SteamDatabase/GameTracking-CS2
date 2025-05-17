// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_PerParticleForce : public CParticleFunctionForce
{
	// MPropertyFriendlyName = "force scale"
	CPerParticleFloatInput m_flForceScale;
	// MPropertyFriendlyName = "force to apply"
	// MVectorIsCoordinate
	CPerParticleVecInput m_vForce;
	// MPropertyFriendlyName = "local space control point"
	int32 m_nCP;
};
