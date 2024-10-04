class C_OP_LockToBone : public CParticleFunctionOperator
{
	CParticleModelInput m_modelInput;
	CParticleTransformInput m_transformInput;
	float32 m_flLifeTimeFadeStart;
	float32 m_flLifeTimeFadeEnd;
	float32 m_flJumpThreshold;
	float32 m_flPrevPosScale;
	char[128] m_HitboxSetName;
	bool m_bRigid;
	bool m_bUseBones;
	ParticleAttributeIndex_t m_nFieldOutput;
	ParticleAttributeIndex_t m_nFieldOutputPrev;
	ParticleRotationLockType_t m_nRotationSetType;
	bool m_bRigidRotationLock;
	CPerParticleVecInput m_vecRotation;
	CPerParticleFloatInput m_flRotLerp;
};
