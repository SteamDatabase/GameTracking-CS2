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
class CPointWorldText : public CModelPointEntity
{
	// MNetworkEnable
	// MNotSaved
	char[512] m_messageText;
	// MNetworkEnable
	// MNotSaved
	char[64] m_FontName;
	// MNetworkEnable
	// MNotSaved
	char[64] m_BackgroundMaterialName;
	// MNetworkEnable
	// MNotSaved
	bool m_bEnabled;
	// MNetworkEnable
	// MNotSaved
	bool m_bFullbright;
	// MNetworkEnable
	// MNotSaved
	float32 m_flWorldUnitsPerPx;
	// MNetworkEnable
	// MNotSaved
	float32 m_flFontSize;
	// MNetworkEnable
	// MNotSaved
	float32 m_flDepthOffset;
	// MNetworkEnable
	// MNotSaved
	bool m_bDrawBackground;
	// MNetworkEnable
	// MNotSaved
	float32 m_flBackgroundBorderWidth;
	// MNetworkEnable
	// MNotSaved
	float32 m_flBackgroundBorderHeight;
	// MNetworkEnable
	// MNotSaved
	float32 m_flBackgroundWorldToUV;
	// MNetworkEnable
	// MNotSaved
	Color m_Color;
	// MNetworkEnable
	// MNotSaved
	PointWorldTextJustifyHorizontal_t m_nJustifyHorizontal;
	// MNetworkEnable
	// MNotSaved
	PointWorldTextJustifyVertical_t m_nJustifyVertical;
	// MNetworkEnable
	// MNotSaved
	PointWorldTextReorientMode_t m_nReorientMode;
};
