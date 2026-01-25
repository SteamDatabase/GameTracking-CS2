class CTriggerPush : public CBaseTrigger
{
	QAngle m_angPushEntitySpace;
	Vector m_vecPushDirEntitySpace;
	bool m_bTriggerOnStartTouch;
	bool m_bUsePathSimple;
	CUtlSymbolLarge m_iszPathSimpleName;
	// MClassPtr
	CPathSimple* m_PathSimple;
	uint32 m_splinePushType;
};
