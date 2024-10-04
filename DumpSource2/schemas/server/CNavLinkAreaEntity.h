class CNavLinkAreaEntity : public CPointEntity
{
	float32 m_flWidth;
	Vector m_vLocatorOffset;
	QAngle m_qLocatorAnglesOffset;
	CUtlSymbolLarge m_strMovementForward;
	CUtlSymbolLarge m_strMovementReverse;
	int32 m_nNavLinkIdForward;
	int32 m_nNavLinkIdReverse;
	bool m_bEnabled;
	CUtlSymbolLarge m_strFilterName;
	CHandle< CBaseFilter > m_hFilter;
	CEntityIOOutput m_OnNavLinkStart;
	CEntityIOOutput m_OnNavLinkFinish;
	bool m_bIsTerminus;
};
