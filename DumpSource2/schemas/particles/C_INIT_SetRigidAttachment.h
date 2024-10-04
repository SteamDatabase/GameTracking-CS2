class C_INIT_SetRigidAttachment : public CParticleFunctionInitializer
{
	int32 m_nControlPointNumber;
	ParticleAttributeIndex_t m_nFieldInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	bool m_bLocalSpace;
};
