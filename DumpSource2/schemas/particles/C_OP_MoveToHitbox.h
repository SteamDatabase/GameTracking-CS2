// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_MoveToHitbox : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "model input"
	CParticleModelInput m_modelInput;
	// MPropertyFriendlyName = "transform input"
	CParticleTransformInput m_transformInput;
	// MPropertyFriendlyName = "lifetime lerp start"
	float32 m_flLifeTimeLerpStart;
	// MPropertyFriendlyName = "lifetime lerp end"
	float32 m_flLifeTimeLerpEnd;
	// MPropertyFriendlyName = "previous position scale"
	float32 m_flPrevPosScale;
	// MPropertyFriendlyName = "hitbox set"
	char[128] m_HitboxSetName;
	// MPropertyFriendlyName = "use bones instead of hitboxes"
	bool m_bUseBones;
	// MPropertyFriendlyName = "lerp type"
	HitboxLerpType_t m_nLerpType;
	// MPropertyFriendlyName = "Constant Interpolation"
	CPerParticleFloatInput m_flInterpolation;
};
