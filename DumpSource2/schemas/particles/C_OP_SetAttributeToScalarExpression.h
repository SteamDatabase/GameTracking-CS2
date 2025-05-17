// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SetAttributeToScalarExpression : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "expression"
	ScalarExpressionType_t m_nExpression;
	// MPropertyFriendlyName = "input 1"
	CPerParticleFloatInput m_flInput1;
	// MPropertyFriendlyName = "input 2"
	CPerParticleFloatInput m_flInput2;
	// MPropertyFriendlyName = "output"
	CParticleRemapFloatInput m_flOutputRemap;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	ParticleAttributeIndex_t m_nOutputField;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
};
