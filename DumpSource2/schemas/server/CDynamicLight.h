class CDynamicLight : public CBaseModelEntity
{
	uint8 m_ActualFlags;
	uint8 m_Flags;
	uint8 m_LightStyle;
	bool m_On;
	float32 m_Radius;
	int32 m_Exponent;
	float32 m_InnerAngle;
	float32 m_OuterAngle;
	float32 m_SpotRadius;
}
