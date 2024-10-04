class C_OP_MoveToHitbox : public CParticleFunctionOperator
{
	CParticleModelInput m_modelInput;
	CParticleTransformInput m_transformInput;
	float32 m_flLifeTimeLerpStart;
	float32 m_flLifeTimeLerpEnd;
	float32 m_flPrevPosScale;
	char[128] m_HitboxSetName;
	bool m_bUseBones;
	HitboxLerpType_t m_nLerpType;
	CPerParticleFloatInput m_flInterpolation;
};
