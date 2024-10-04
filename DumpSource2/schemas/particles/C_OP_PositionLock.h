class C_OP_PositionLock : public CParticleFunctionOperator
{
	CParticleTransformInput m_TransformInput;
	float32 m_flStartTime_min;
	float32 m_flStartTime_max;
	float32 m_flStartTime_exp;
	float32 m_flEndTime_min;
	float32 m_flEndTime_max;
	float32 m_flEndTime_exp;
	float32 m_flRange;
	CParticleCollectionFloatInput m_flRangeBias;
	float32 m_flJumpThreshold;
	float32 m_flPrevPosScale;
	bool m_bLockRot;
	CParticleCollectionVecInput m_vecScale;
	ParticleAttributeIndex_t m_nFieldOutput;
	ParticleAttributeIndex_t m_nFieldOutputPrev;
};
