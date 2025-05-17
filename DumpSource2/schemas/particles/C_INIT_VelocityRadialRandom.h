// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_VelocityRadialRandom : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "random speed min"
	CPerParticleFloatInput m_fSpeedMin;
	// MPropertyFriendlyName = "random speed max"
	CPerParticleFloatInput m_fSpeedMax;
	// MPropertyFriendlyName = "local space scale"
	Vector m_vecLocalCoordinateSystemSpeedScale;
	// MPropertyFriendlyName = "ignore delta time"
	bool m_bIgnoreDelta;
};
