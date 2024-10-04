class C_OP_SetControlPointFieldFromVectorExpression : public CParticleFunctionPreEmission
{
	VectorFloatExpressionType_t m_nExpression;
	CParticleCollectionVecInput m_vecInput1;
	CParticleCollectionVecInput m_vecInput2;
	CParticleRemapFloatInput m_flOutputRemap;
	int32 m_nOutputCP;
	int32 m_nOutVectorField;
};
