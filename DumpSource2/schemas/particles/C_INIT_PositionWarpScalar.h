class C_INIT_PositionWarpScalar : public CParticleFunctionInitializer
{
	Vector m_vecWarpMin;
	Vector m_vecWarpMax;
	CPerParticleFloatInput m_InputValue;
	float32 m_flPrevPosScale;
	int32 m_nScaleControlPointNumber;
	int32 m_nControlPointNumber;
};
