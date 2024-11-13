class C_PointWorldText : public C_ModelPointEntity
{
	bool m_bForceRecreateNextUpdate;
	char[512] m_messageText;
	char[64] m_FontName;
	char[64] m_BackgroundMaterialName;
	bool m_bEnabled;
	bool m_bFullbright;
	float32 m_flWorldUnitsPerPx;
	float32 m_flFontSize;
	float32 m_flDepthOffset;
	bool m_bDrawBackground;
	float32 m_flBackgroundBorderWidth;
	float32 m_flBackgroundBorderHeight;
	float32 m_flBackgroundWorldToUV;
	Color m_Color;
	PointWorldTextJustifyHorizontal_t m_nJustifyHorizontal;
	PointWorldTextJustifyVertical_t m_nJustifyVertical;
	PointWorldTextReorientMode_t m_nReorientMode;
};
