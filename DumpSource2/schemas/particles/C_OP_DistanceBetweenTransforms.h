class C_OP_DistanceBetweenTransforms : public CParticleFunctionOperator
{
	ParticleAttributeIndex_t m_nFieldOutput;
	CParticleTransformInput m_TransformStart;
	CParticleTransformInput m_TransformEnd;
	CPerParticleFloatInput m_flInputMin;
	CPerParticleFloatInput m_flInputMax;
	CPerParticleFloatInput m_flOutputMin;
	CPerParticleFloatInput m_flOutputMax;
	float32 m_flMaxTraceLength;
	float32 m_flLOSScale;
	char[128] m_CollisionGroupName;
	ParticleTraceSet_t m_nTraceSet;
	bool m_bLOS;
	ParticleSetMethod_t m_nSetMethod;
};
