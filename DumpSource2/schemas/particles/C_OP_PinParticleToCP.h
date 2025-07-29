// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_PinParticleToCP : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "offset"
	CParticleCollectionVecInput m_vecOffset;
	// MPropertyFriendlyName = "offset in local space"
	bool m_bOffsetLocal;
	// MPropertyFriendlyName = "particle to use"
	ParticleSelection_t m_nParticleSelection;
	// MPropertyFriendlyName = "particle number/offset"
	CParticleCollectionFloatInput m_nParticleNumber;
	// MPropertyFriendlyName = "pin break type"
	ParticlePinDistance_t m_nPinBreakType;
	// MPropertyFriendlyName = "break length %"
	CParticleCollectionFloatInput m_flBreakDistance;
	// MPropertyFriendlyName = "break speed"
	CParticleCollectionFloatInput m_flBreakSpeed;
	// MPropertyFriendlyName = "break age"
	CParticleCollectionFloatInput m_flAge;
	// MPropertyFriendlyName = "break comparison control point 1"
	int32 m_nBreakControlPointNumber;
	// MPropertyFriendlyName = "break comparison control point 2"
	int32 m_nBreakControlPointNumber2;
	// MPropertyFriendlyName = "break value"
	CParticleCollectionFloatInput m_flBreakValue;
	// MPropertyFriendlyName = "Interpolation"
	CPerParticleFloatInput m_flInterpolation;
	// MPropertyFriendlyName = "Retain Initial Velocity "
	// MPropertySuppressExpr = "m_nParticleSelection != PARTICLE_SELECTION_LAST"
	bool m_bRetainInitialVelocity;
};
