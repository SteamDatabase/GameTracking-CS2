class C_OP_MovementPlaceOnGround : public CParticleFunctionOperator
{
	CPerParticleFloatInput m_flOffset;
	float32 m_flMaxTraceLength;
	float32 m_flTolerance;
	float32 m_flTraceOffset;
	float32 m_flLerpRate;
	char[128] m_CollisionGroupName;
	ParticleTraceSet_t m_nTraceSet;
	int32 m_nRefCP1;
	int32 m_nRefCP2;
	int32 m_nLerpCP;
	ParticleTraceMissBehavior_t m_nTraceMissBehavior;
	bool m_bIncludeShotHull;
	bool m_bIncludeWater;
	bool m_bSetNormal;
	bool m_bScaleOffset;
	int32 m_nPreserveOffsetCP;
	int32 m_nIgnoreCP;
};
