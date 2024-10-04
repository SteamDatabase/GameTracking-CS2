class CTriggerLook : public CTriggerOnce
{
	CHandle< CBaseEntity > m_hLookTarget;
	float32 m_flFieldOfView;
	float32 m_flLookTime;
	float32 m_flLookTimeTotal;
	GameTime_t m_flLookTimeLast;
	float32 m_flTimeoutDuration;
	bool m_bTimeoutFired;
	bool m_bIsLooking;
	bool m_b2DFOV;
	bool m_bUseVelocity;
	bool m_bTestOcclusion;
	CEntityIOOutput m_OnTimeout;
	CEntityIOOutput m_OnStartLook;
	CEntityIOOutput m_OnEndLook;
}
