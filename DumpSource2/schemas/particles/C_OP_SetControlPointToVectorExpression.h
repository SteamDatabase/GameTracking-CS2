// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetControlPointToVectorExpression : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "expression"
	VectorExpressionType_t m_nExpression;
	// MPropertyFriendlyName = "output control point"
	int32 m_nOutputCP;
	// MPropertyFriendlyName = "input 1"
	CParticleCollectionVecInput m_vInput1;
	// MPropertyFriendlyName = "input 2"
	CParticleCollectionVecInput m_vInput2;
	// MPropertyFriendlyName = "normalize result"
	bool m_bNormalizedOutput;
};
