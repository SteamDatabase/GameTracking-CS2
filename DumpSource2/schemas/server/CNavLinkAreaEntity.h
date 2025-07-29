class CNavLinkAreaEntity : public CPointEntity
{
	float32 m_flWidth;
	Vector m_vLocatorOffset;
	QAngle m_qLocatorAnglesOffset;
	CUtlSymbolLarge m_strMovementForward;
	CUtlSymbolLarge m_strMovementReverse;
	bool m_bEnabled;
	bool m_bAllowCrossMovableConnections;
	CUtlSymbolLarge m_strFilterName;
	CHandle< CBaseFilter > m_hFilter;
	CEntityIOOutput m_OnNavLinkStart;
	CEntityIOOutput m_OnNavLinkFinish;
	bool m_bIsTerminus;
	int32 m_nSplits;
};
