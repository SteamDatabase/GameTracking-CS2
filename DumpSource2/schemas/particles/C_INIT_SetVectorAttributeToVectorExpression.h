// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_SetVectorAttributeToVectorExpression : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "expression"
	VectorExpressionType_t m_nExpression;
	// MPropertyFriendlyName = "input 1"
	CPerParticleVecInput m_vInput1;
	// MPropertyFriendlyName = "input 2"
	CPerParticleVecInput m_vInput2;
	// MPropertyFriendlyName = "lerp value"
	// MPropertySuppressExpr = "m_nExpression != VECTOR_EXPRESSION_LERP"
	CPerParticleFloatInput m_flLerp;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_vector"
	ParticleAttributeIndex_t m_nOutputField;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "normalize result"
	bool m_bNormalizedOutput;
};
