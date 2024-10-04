class CBaseToggle : public CBaseModelEntity
{
	TOGGLE_STATE m_toggle_state;
	float32 m_flMoveDistance;
	float32 m_flWait;
	float32 m_flLip;
	bool m_bAlwaysFireBlockedOutputs;
	Vector m_vecPosition1;
	Vector m_vecPosition2;
	QAngle m_vecMoveAng;
	QAngle m_vecAngle1;
	QAngle m_vecAngle2;
	float32 m_flHeight;
	CHandle< CBaseEntity > m_hActivator;
	Vector m_vecFinalDest;
	QAngle m_vecFinalAngle;
	int32 m_movementType;
	CUtlSymbolLarge m_sMaster;
}
