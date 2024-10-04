class C_OP_AttractToControlPoint : public CParticleFunctionForce
{
	Vector m_vecComponentScale;
	CPerParticleFloatInput m_fForceAmount;
	float32 m_fFalloffPower;
	CParticleTransformInput m_TransformInput;
	CPerParticleFloatInput m_fForceAmountMin;
	bool m_bApplyMinForce;
};
