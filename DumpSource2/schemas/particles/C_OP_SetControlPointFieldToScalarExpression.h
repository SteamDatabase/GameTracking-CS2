// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetControlPointFieldToScalarExpression : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "expression"
	ScalarExpressionType_t m_nExpression;
	// MPropertyFriendlyName = "input 1"
	CParticleCollectionFloatInput m_flInput1;
	// MPropertyFriendlyName = "input 2"
	CParticleCollectionFloatInput m_flInput2;
	// MPropertyFriendlyName = "output"
	CParticleRemapFloatInput m_flOutputRemap;
	// MPropertyFriendlyName = "output control point"
	int32 m_nOutputCP;
	// MPropertyFriendlyName = "output component"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nOutVectorField;
};
