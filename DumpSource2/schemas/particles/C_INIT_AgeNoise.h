// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_AgeNoise : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "absolute value"
	bool m_bAbsVal;
	// MPropertyFriendlyName = "invert absolute value"
	bool m_bAbsValInv;
	// MPropertyFriendlyName = "time coordinate offset"
	float32 m_flOffset;
	// MPropertyFriendlyName = "start age minimum"
	float32 m_flAgeMin;
	// MPropertyFriendlyName = "start age maximum"
	float32 m_flAgeMax;
	// MPropertyFriendlyName = "time noise coordinate scale"
	float32 m_flNoiseScale;
	// MPropertyFriendlyName = "spatial noise coordinate scale"
	float32 m_flNoiseScaleLoc;
	// MPropertyFriendlyName = "spatial coordinate offset"
	// MVectorIsCoordinate
	Vector m_vecOffsetLoc;
};
