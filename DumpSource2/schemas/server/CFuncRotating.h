// MNetworkOverride = "m_angRotation CGameSceneNode"
// MNetworkOverride = "m_flSimulationTime CBaseEntity"
class CFuncRotating : public CBaseModelEntity
{
	CEntityIOOutput m_OnStopped;
	CEntityIOOutput m_OnStarted;
	CEntityIOOutput m_OnReachedStart;
	RotationVector m_localRotationVector;
	float32 m_flFanFriction;
	float32 m_flAttenuation;
	float32 m_flVolume;
	float32 m_flTargetSpeed;
	float32 m_flMaxSpeed;
	float32 m_flBlockDamage;
	CUtlSymbolLarge m_NoiseRunning;
	bool m_bReversed;
	bool m_bAccelDecel;
	QAngle m_prevLocalAngles;
	QAngle m_angStart;
	bool m_bStopAtStartPos;
	Vector m_vecClientOrigin;
	QAngle m_vecClientAngles;
};
