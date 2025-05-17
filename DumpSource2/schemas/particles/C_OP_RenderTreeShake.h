// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RenderTreeShake : public CParticleFunctionRenderer
{
	// MPropertyFriendlyName = "peak strength"
	float32 m_flPeakStrength;
	// MPropertyFriendlyName = "peak strength field override"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nPeakStrengthFieldOverride;
	// MPropertyFriendlyName = "radius"
	float32 m_flRadius;
	// MPropertyFriendlyName = "strength field override"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nRadiusFieldOverride;
	// MPropertyFriendlyName = "shake duration after end"
	float32 m_flShakeDuration;
	// MPropertyFriendlyName = "amount of time taken to smooth between different shake parameters"
	float32 m_flTransitionTime;
	// MPropertyFriendlyName = "Twist amount (-1..1)"
	float32 m_flTwistAmount;
	// MPropertyFriendlyName = "Radial Amount (-1..1)"
	float32 m_flRadialAmount;
	// MPropertyFriendlyName = "Control Point Orientation Amount (-1..1)"
	float32 m_flControlPointOrientationAmount;
	// MPropertyFriendlyName = "Control Point for Orientation Amount"
	int32 m_nControlPointForLinearDirection;
};
