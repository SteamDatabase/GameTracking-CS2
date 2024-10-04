class C_OP_SetControlPointToVectorExpression : public CParticleFunctionPreEmission
{
	VectorExpressionType_t m_nExpression;
	int32 m_nOutputCP;
	CParticleCollectionVecInput m_vInput1;
	CParticleCollectionVecInput m_vInput2;
	bool m_bNormalizedOutput;
};
