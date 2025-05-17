// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_CreateSpiralSphere : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "override CP (X/Y/Z *= radius/density/speed)"
	int32 m_nOverrideCP;
	// MPropertyFriendlyName = "density"
	int32 m_nDensity;
	// MPropertyFriendlyName = "initial radius"
	float32 m_flInitialRadius;
	// MPropertyFriendlyName = "min initial speed"
	float32 m_flInitialSpeedMin;
	// MPropertyFriendlyName = "max initial speed"
	float32 m_flInitialSpeedMax;
	// MPropertyFriendlyName = "use particle count as density scale"
	bool m_bUseParticleCount;
};
