// MNetworkVarNames = "uint8 m_Flags"
// MNetworkVarNames = "uint8 m_LightStyle"
// MNetworkVarNames = "float32 m_Radius"
// MNetworkVarNames = "int32 m_Exponent"
// MNetworkVarNames = "float32 m_InnerAngle"
// MNetworkVarNames = "float32 m_OuterAngle"
// MNetworkVarNames = "float32 m_SpotRadius"
class C_DynamicLight : public C_BaseModelEntity
{
	// MNetworkEnable
	// MNotSaved
	uint8 m_Flags;
	// MNetworkEnable
	// MNotSaved
	uint8 m_LightStyle;
	// MNetworkEnable
	// MNotSaved
	float32 m_Radius;
	// MNetworkEnable
	// MNotSaved
	int32 m_Exponent;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 360.000000
	// MNotSaved
	float32 m_InnerAngle;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 360.000000
	// MNotSaved
	float32 m_OuterAngle;
	// MNetworkEnable
	// MNotSaved
	float32 m_SpotRadius;
};
