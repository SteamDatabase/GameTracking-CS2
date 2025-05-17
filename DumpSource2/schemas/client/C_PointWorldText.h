// MNetworkVarNames = "char m_messageText"
// MNetworkVarNames = "char m_FontName"
// MNetworkVarNames = "char m_BackgroundMaterialName"
// MNetworkVarNames = "bool m_bEnabled"
// MNetworkVarNames = "bool m_bFullbright"
// MNetworkVarNames = "float m_flWorldUnitsPerPx"
// MNetworkVarNames = "float m_flFontSize"
// MNetworkVarNames = "float m_flDepthOffset"
// MNetworkVarNames = "bool m_bDrawBackground"
// MNetworkVarNames = "float m_flBackgroundBorderWidth"
// MNetworkVarNames = "float m_flBackgroundBorderHeight"
// MNetworkVarNames = "float m_flBackgroundWorldToUV"
// MNetworkVarNames = "Color m_Color"
// MNetworkVarNames = "PointWorldTextJustifyHorizontal_t m_nJustifyHorizontal"
// MNetworkVarNames = "PointWorldTextJustifyVertical_t m_nJustifyVertical"
// MNetworkVarNames = "PointWorldTextReorientMode_t m_nReorientMode"
class C_PointWorldText : public C_ModelPointEntity
{
	bool m_bForceRecreateNextUpdate;
	// MNetworkEnable
	char[512] m_messageText;
	// MNetworkEnable
	char[64] m_FontName;
	// MNetworkEnable
	char[64] m_BackgroundMaterialName;
	// MNetworkEnable
	bool m_bEnabled;
	// MNetworkEnable
	bool m_bFullbright;
	// MNetworkEnable
	float32 m_flWorldUnitsPerPx;
	// MNetworkEnable
	float32 m_flFontSize;
	// MNetworkEnable
	float32 m_flDepthOffset;
	// MNetworkEnable
	bool m_bDrawBackground;
	// MNetworkEnable
	float32 m_flBackgroundBorderWidth;
	// MNetworkEnable
	float32 m_flBackgroundBorderHeight;
	// MNetworkEnable
	float32 m_flBackgroundWorldToUV;
	// MNetworkEnable
	Color m_Color;
	// MNetworkEnable
	PointWorldTextJustifyHorizontal_t m_nJustifyHorizontal;
	// MNetworkEnable
	PointWorldTextJustifyVertical_t m_nJustifyVertical;
	// MNetworkEnable
	PointWorldTextReorientMode_t m_nReorientMode;
};
