class CPointWorldText : public CModelPointEntity
{
	char[512] m_messageText;
	char[64] m_FontName;
	bool m_bEnabled;
	bool m_bFullbright;
	float32 m_flWorldUnitsPerPx;
	float32 m_flFontSize;
	float32 m_flDepthOffset;
	Color m_Color;
	PointWorldTextJustifyHorizontal_t m_nJustifyHorizontal;
	PointWorldTextJustifyVertical_t m_nJustifyVertical;
	PointWorldTextReorientMode_t m_nReorientMode;
};
