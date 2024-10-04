class C_OP_SetControlPointFieldToScalarExpression : public CParticleFunctionPreEmission
{
	ScalarExpressionType_t m_nExpression;
	CParticleCollectionFloatInput m_flInput1;
	CParticleCollectionFloatInput m_flInput2;
	CParticleRemapFloatInput m_flOutputRemap;
	int32 m_nOutputCP;
	int32 m_nOutVectorField;
};
