// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_AttractToControlPoint : public CParticleFunctionForce
{
	// MPropertyFriendlyName = "component scale"
	// MVectorIsCoordinate
	Vector m_vecComponentScale;
	// MPropertyFriendlyName = "amount of force (or Max Force)"
	CPerParticleFloatInput m_fForceAmount;
	// MPropertyFriendlyName = "falloff power"
	float32 m_fFalloffPower;
	// MPropertyFriendlyName = "input position transform"
	CParticleTransformInput m_TransformInput;
	// MPropertyFriendlyName = "Min Pullforce"
	CPerParticleFloatInput m_fForceAmountMin;
	// MPropertyFriendlyName = "Apply Min Pullforce"
	bool m_bApplyMinForce;
};
