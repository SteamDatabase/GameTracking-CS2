class C_OP_CylindricalDistanceToTransform : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	CPerParticleFloatInput m_flInputMin;
	CPerParticleFloatInput m_flInputMax;
	CPerParticleFloatInput m_flOutputMin;
	CPerParticleFloatInput m_flOutputMax;
	CParticleTransformInput m_TransformStart;
	CParticleTransformInput m_TransformEnd;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bActiveRange;
	bool m_bAdditive;
	bool m_bCapsule;
};
