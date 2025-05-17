// MNetworkVarNames = "uint8 m_Flags"
// MNetworkVarNames = "uint8 m_LightStyle"
// MNetworkVarNames = "float32 m_Radius"
// MNetworkVarNames = "int32 m_Exponent"
// MNetworkVarNames = "float32 m_InnerAngle"
// MNetworkVarNames = "float32 m_OuterAngle"
// MNetworkVarNames = "float32 m_SpotRadius"
class CDynamicLight : public CBaseModelEntity
{
	uint8 m_ActualFlags;
	// MNetworkEnable
	uint8 m_Flags;
	// MNetworkEnable
	uint8 m_LightStyle;
	bool m_On;
	// MNetworkEnable
	float32 m_Radius;
	// MNetworkEnable
	int32 m_Exponent;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 360.000000
	float32 m_InnerAngle;
	// MNetworkEnable
	// MNetworkBitCount = 8
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 360.000000
	float32 m_OuterAngle;
	// MNetworkEnable
	float32 m_SpotRadius;
};
