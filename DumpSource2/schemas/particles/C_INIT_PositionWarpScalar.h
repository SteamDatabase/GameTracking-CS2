// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_PositionWarpScalar : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "warp min"
	// MVectorIsCoordinate
	Vector m_vecWarpMin;
	// MPropertyFriendlyName = "warp max"
	// MVectorIsCoordinate
	Vector m_vecWarpMax;
	// MPropertyFriendlyName = "warp amount"
	CPerParticleFloatInput m_InputValue;
	// MPropertyFriendlyName = "previous position scale"
	float32 m_flPrevPosScale;
	// MPropertyFriendlyName = "warp scale control point number"
	int32 m_nScaleControlPointNumber;
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
};
