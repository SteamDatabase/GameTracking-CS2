class CKeepUpright : public CPointEntity
{
	Vector m_worldGoalAxis;
	Vector m_localTestAxis;
	CUtlSymbolLarge m_nameAttach;
	CHandle< CBaseEntity > m_attachedObject;
	float32 m_angularLimit;
	bool m_bActive;
	bool m_bDampAllRotation;
};
