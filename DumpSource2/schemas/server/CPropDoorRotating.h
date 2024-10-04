class CPropDoorRotating : public CBasePropDoor
{
	Vector m_vecAxis;
	float32 m_flDistance;
	PropDoorRotatingSpawnPos_t m_eSpawnPosition;
	PropDoorRotatingOpenDirection_e m_eOpenDirection;
	PropDoorRotatingOpenDirection_e m_eCurrentOpenDirection;
	float32 m_flAjarAngle;
	QAngle m_angRotationAjarDeprecated;
	QAngle m_angRotationClosed;
	QAngle m_angRotationOpenForward;
	QAngle m_angRotationOpenBack;
	QAngle m_angGoal;
	Vector m_vecForwardBoundsMin;
	Vector m_vecForwardBoundsMax;
	Vector m_vecBackBoundsMin;
	Vector m_vecBackBoundsMax;
	bool m_bAjarDoorShouldntAlwaysOpen;
	CHandle< CEntityBlocker > m_hEntityBlocker;
};
