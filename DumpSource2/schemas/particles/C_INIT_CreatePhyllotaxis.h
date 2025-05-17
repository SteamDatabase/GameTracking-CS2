// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_CreatePhyllotaxis : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "scale size multiplier from CP"
	int32 m_nScaleCP;
	// MPropertyFriendlyName = "scale CP component 0/1/2 X/Y/Z"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nComponent;
	// MPropertyFriendlyName = "center core radius"
	float32 m_fRadCentCore;
	// MPropertyFriendlyName = "radius multiplier"
	float32 m_fRadPerPoint;
	// MPropertyFriendlyName = "radius max (-1 procedural growth)"
	float32 m_fRadPerPointTo;
	// MPropertyFriendlyName = "golden angle (is 137.508)"
	float32 m_fpointAngle;
	// MPropertyFriendlyName = "overall size multiplier (-1 count based distribution)"
	float32 m_fsizeOverall;
	// MPropertyFriendlyName = "radius bias"
	float32 m_fRadBias;
	// MPropertyFriendlyName = "radius min "
	float32 m_fMinRad;
	// MPropertyFriendlyName = "distribution bias"
	float32 m_fDistBias;
	// MPropertyFriendlyName = "local space"
	bool m_bUseLocalCoords;
	// MPropertyFriendlyName = "use continuous emission"
	bool m_bUseWithContEmit;
	// MPropertyFriendlyName = "scale radius from initial value"
	bool m_bUseOrigRadius;
};
