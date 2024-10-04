class C_OP_MovementRigidAttachToCP : public CParticleFunctionOperator
{
	int32 m_nControlPointNumber;
	int32 m_nScaleControlPoint;
	int32 m_nScaleCPField;
	ParticleAttributeIndex_t m_nFieldInput;
	ParticleAttributeIndex_t m_nFieldOutput;
	bool m_bOffsetLocal;
};
