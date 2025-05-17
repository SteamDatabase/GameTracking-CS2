// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ExternalWindForce : public CParticleFunctionForce
{
	// MPropertyFriendlyName = "sample position"
	CPerParticleVecInput m_vecSamplePosition;
	// MPropertyFriendlyName = "force scale"
	CPerParticleVecInput m_vecScale;
	// MPropertyFriendlyName = "sample wind"
	bool m_bSampleWind;
	// MPropertyFriendlyName = "sample water current"
	bool m_bSampleWater;
	// MPropertyFriendlyName = "dampen gravity/buoyancy near water plane"
	// MPropertySuppressExpr = "!m_bSampleWater"
	bool m_bDampenNearWaterPlane;
	// MPropertyFriendlyName = "sample local gravity"
	bool m_bSampleGravity;
	// MPropertyFriendlyName = "gravity force"
	// MPropertySuppressExpr = "m_bSampleGravity"
	CPerParticleVecInput m_vecGravityForce;
	// MPropertyFriendlyName = "use Movement Basic for Local Gravity & Buoyancy Scale"
	// MPropertySuppressExpr = "!m_bSampleGravity"
	bool m_bUseBasicMovementGravity;
	// MPropertyFriendlyName = "local gravity scale"
	// MPropertySuppressExpr = "!m_bSampleGravity"
	CPerParticleFloatInput m_flLocalGravityScale;
	// MPropertyFriendlyName = "local gravity buoyancy scale"
	// MPropertySuppressExpr = "!m_bSampleGravity"
	CPerParticleFloatInput m_flLocalBuoyancyScale;
	// MPropertyFriendlyName = "buoyancy force"
	// MPropertySuppressExpr = "!m_bSampleWater || m_bSampleGravity"
	CPerParticleVecInput m_vecBuoyancyForce;
};
