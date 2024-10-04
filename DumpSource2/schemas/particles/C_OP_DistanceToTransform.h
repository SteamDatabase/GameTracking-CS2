class C_OP_DistanceToTransform : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	CPerParticleFloatInput m_flInputMin;
	CPerParticleFloatInput m_flInputMax;
	CPerParticleFloatInput m_flOutputMin;
	CPerParticleFloatInput m_flOutputMax;
	CParticleTransformInput m_TransformStart;
	bool m_bLOS;
	char[128] m_CollisionGroupName;
	ParticleTraceSet_t m_nTraceSet;
	float32 m_flMaxTraceLength;
	float32 m_flLOSScale;
	ParticleSetMethod_t m_nSetMethod;
	bool m_bActiveRange;
	bool m_bAdditive;
	CPerParticleVecInput m_vecComponentScale;
};
