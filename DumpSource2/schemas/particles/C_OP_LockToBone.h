// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_LockToBone : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "model input"
	CParticleModelInput m_modelInput;
	// MPropertyFriendlyName = "transform input"
	CParticleTransformInput m_transformInput;
	// MPropertyFriendlyName = "lifetime fade start"
	float32 m_flLifeTimeFadeStart;
	// MPropertyFriendlyName = "lifetime fade end"
	float32 m_flLifeTimeFadeEnd;
	// MPropertyFriendlyName = "instant jump threshold"
	float32 m_flJumpThreshold;
	// MPropertyFriendlyName = "previous position scale"
	float32 m_flPrevPosScale;
	// MPropertyFriendlyName = "hitbox set"
	char[128] m_HitboxSetName;
	// MPropertyFriendlyName = "rigid lock"
	bool m_bRigid;
	// MPropertyFriendlyName = "use bones instead of hitboxes"
	bool m_bUseBones;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutput;
	// MPropertyFriendlyName = "output field prev"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nFieldOutputPrev;
	// MPropertyStartGroup = "Set Rotations to Bones"
	// MPropertyFriendlyName = "lock rotations to bone orientation"
	ParticleRotationLockType_t m_nRotationSetType;
	// MPropertyFriendlyName = "rigid set rotation from bones"
	bool m_bRigidRotationLock;
	// MPropertyFriendlyName = "rigid rotation offset pitch/yaw/roll"
	CPerParticleVecInput m_vecRotation;
	// MPropertyFriendlyName = "rigid rotation interpolation"
	CPerParticleFloatInput m_flRotLerp;
};
