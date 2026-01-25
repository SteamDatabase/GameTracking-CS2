class CPropDoorRotating : public CBasePropDoor
{
	Vector m_vecAxis;
	float32 m_flDistance;
	PropDoorRotatingSpawnPos_t m_eSpawnPosition;
	PropDoorRotatingOpenDirection_e m_eOpenDirection;
	// MNotSaved
	PropDoorRotatingOpenDirection_e m_eCurrentOpenDirection;
	// MNotSaved
	doorCheck_e m_eDefaultCheckDirection;
	float32 m_flAjarAngle;
	QAngle m_angRotationAjarDeprecated;
	QAngle m_angRotationClosed;
	QAngle m_angRotationOpenForward;
	QAngle m_angRotationOpenBack;
	QAngle m_angGoal;
	// MNotSaved
	Vector m_vecForwardBoundsMin;
	// MNotSaved
	Vector m_vecForwardBoundsMax;
	// MNotSaved
	Vector m_vecBackBoundsMin;
	// MNotSaved
	Vector m_vecBackBoundsMax;
	bool m_bAjarDoorShouldntAlwaysOpen;
	CHandle< CEntityBlocker > m_hEntityBlocker;
};
