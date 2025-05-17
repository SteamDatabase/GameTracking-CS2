// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_LerpToInitialPosition : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "Interpolation"
	CPerParticleFloatInput m_flInterpolation;
	// MPropertyFriendlyName = "position cache attribute"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nCacheField;
	// MPropertyFriendlyName = "scale"
	CParticleCollectionFloatInput m_flScale;
	// MPropertyFriendlyName = "component scale"
	CParticleCollectionVecInput m_vecScale;
};
