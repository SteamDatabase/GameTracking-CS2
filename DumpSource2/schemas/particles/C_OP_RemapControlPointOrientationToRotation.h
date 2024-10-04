class C_OP_RemapControlPointOrientationToRotation : public CParticleFunctionOperator
{
	int32 m_nCP;
	ParticleAttributeIndex_t m_nFieldOutput;
	float32 m_flOffsetRot;
	int32 m_nComponent;
};
