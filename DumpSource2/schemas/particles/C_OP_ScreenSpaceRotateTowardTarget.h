// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_ScreenSpaceRotateTowardTarget : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "target position"
	// MVectorIsCoordinate
	CPerParticleVecInput m_vecTargetPosition;
	// MPropertyFriendlyName = "output"
	CParticleRemapFloatInput m_flOutputRemap;
	// MPropertyFriendlyName = "set value method"
	ParticleSetMethod_t m_nSetMethod;
	// MPropertyFriendlyName = "screen edge alignment distance"
	CPerParticleFloatInput m_flScreenEdgeAlignmentDistance;
};
