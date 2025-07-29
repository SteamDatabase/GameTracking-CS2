// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ScreenSpacePositionOfTarget : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "target position"
	// MVectorIsCoordinate
	CPerParticleVecInput m_vecTargetPosition;
	// MPropertyFriendlyName = "output behindness"
	bool m_bOututBehindness;
	// MPropertyFriendlyName = "behindness output field"
	// MPropertyAttributeChoiceName = "particlefield_scalar"
	// MPropertySuppressExpr = "m_bOututBehindness == false"
	ParticleAttributeIndex_t m_nBehindFieldOutput;
	// MPropertyFriendlyName = "behindness output remap"
	// MPropertySuppressExpr = "m_bOututBehindness == false"
	CParticleRemapFloatInput m_flBehindOutputRemap;
	// MPropertyFriendlyName = "behindness set value method"
	// MPropertySuppressExpr = "m_bOututBehindness == false"
	ParticleSetMethod_t m_nBehindSetMethod;
};
