class C_OP_SetVariable : public CParticleFunctionPreEmission
{
	CParticleVariableRef m_variableReference;
	CParticleTransformInput m_transformInput;
	Vector m_positionOffset;
	QAngle m_rotationOffset;
	CParticleCollectionVecInput m_vecInput;
	CParticleCollectionFloatInput m_floatInput;
};
