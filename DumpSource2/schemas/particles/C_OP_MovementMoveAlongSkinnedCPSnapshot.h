class C_OP_MovementMoveAlongSkinnedCPSnapshot : public CParticleFunctionOperator
{
	int32 m_nControlPointNumber;
	int32 m_nSnapshotControlPointNumber;
	bool m_bSetNormal;
	bool m_bSetRadius;
	CPerParticleFloatInput m_flInterpolation;
	CPerParticleFloatInput m_flTValue;
};
