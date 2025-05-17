// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_MovementMoveAlongSkinnedCPSnapshot : public CParticleFunctionOperator
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "snapshot control point number"
	int32 m_nSnapshotControlPointNumber;
	// MPropertyFriendlyName = "set normal"
	bool m_bSetNormal;
	// MPropertyFriendlyName = "set radius"
	bool m_bSetRadius;
	// MPropertyFriendlyName = "Interpolation"
	CPerParticleFloatInput m_flInterpolation;
	// MPropertyFriendlyName = "Snapshot Index T Value"
	CPerParticleFloatInput m_flTValue;
};
