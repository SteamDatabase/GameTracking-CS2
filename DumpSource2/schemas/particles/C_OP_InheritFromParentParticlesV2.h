class C_OP_InheritFromParentParticlesV2 : public CParticleFunctionOperator
{
	float32 m_flScale;
	ParticleAttributeIndex_t m_nFieldOutput;
	int32 m_nIncrement;
	bool m_bRandomDistribution;
	MissingParentInheritBehavior_t m_nMissingParentBehavior;
};
