// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_PositionLock : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "transform input"
	CParticleTransformInput m_TransformInput;
	// MPropertyFriendlyName = "start fadeout min"
	float32 m_flStartTime_min;
	// MPropertyFriendlyName = "start fadeout max"
	float32 m_flStartTime_max;
	// MPropertyFriendlyName = "start fadeout exponent"
	float32 m_flStartTime_exp;
	// MPropertyFriendlyName = "end fadeout min"
	float32 m_flEndTime_min;
	// MPropertyFriendlyName = "end fadeout max"
	float32 m_flEndTime_max;
	// MPropertyFriendlyName = "end fadeout exponent"
	float32 m_flEndTime_exp;
	// MPropertyFriendlyName = "distance fade range"
	float32 m_flRange;
	// MPropertyFriendlyName = "distance fade bias"
	CParticleCollectionFloatInput m_flRangeBias;
	// MPropertyFriendlyName = "instant jump threshold"
	float32 m_flJumpThreshold;
	// MPropertyFriendlyName = "previous position scale"
	float32 m_flPrevPosScale;
	// MPropertyFriendlyName = "lock rotation"
	bool m_bLockRot;
	// MPropertyFriendlyName = "component scale"
	CParticleCollectionVecInput m_vecScale;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "output field prev"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutputPrev;
};
