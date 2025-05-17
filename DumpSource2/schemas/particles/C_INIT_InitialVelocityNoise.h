// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_InitialVelocityNoise : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "absolute value"
	// MVectorIsCoordinate
	Vector m_vecAbsVal;
	// MPropertyFriendlyName = "invert abs value"
	// MVectorIsCoordinate
	Vector m_vecAbsValInv;
	// MPropertyFriendlyName = "spatial coordinate offset"
	// MVectorIsCoordinate
	CPerParticleVecInput m_vecOffsetLoc;
	// MPropertyFriendlyName = "time coordinate offset"
	CPerParticleFloatInput m_flOffset;
	// MPropertyFriendlyName = "output minimum"
	CPerParticleVecInput m_vecOutputMin;
	// MPropertyFriendlyName = "output maximum"
	CPerParticleVecInput m_vecOutputMax;
	// MPropertyFriendlyName = "time noise coordinate scale"
	CPerParticleFloatInput m_flNoiseScale;
	// MPropertyFriendlyName = "spatial noise coordinate scale"
	CPerParticleFloatInput m_flNoiseScaleLoc;
	// MPropertyFriendlyName = "input local space velocity (optional)"
	// MParticleInputOptional
	CParticleTransformInput m_TransformInput;
	// MPropertyFriendlyName = "ignore delta time"
	bool m_bIgnoreDt;
};
