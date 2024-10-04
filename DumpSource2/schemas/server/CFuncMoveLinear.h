class CFuncMoveLinear : public CBaseToggle
{
	MoveLinearAuthoredPos_t m_authoredPosition;
	QAngle m_angMoveEntitySpace;
	Vector m_vecMoveDirParentSpace;
	CUtlSymbolLarge m_soundStart;
	CUtlSymbolLarge m_soundStop;
	CUtlSymbolLarge m_currentSound;
	float32 m_flBlockDamage;
	float32 m_flStartPosition;
	CEntityIOOutput m_OnFullyOpen;
	CEntityIOOutput m_OnFullyClosed;
	bool m_bCreateMovableNavMesh;
	bool m_bCreateNavObstacle;
};
