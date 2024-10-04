class C_PlantedC4 : public CBaseAnimGraph
{
	bool m_bBombTicking;
	int32 m_nBombSite;
	int32 m_nSourceSoundscapeHash;
	EntitySpottedState_t m_entitySpottedState;
	GameTime_t m_flNextGlow;
	GameTime_t m_flNextBeep;
	GameTime_t m_flC4Blow;
	bool m_bCannotBeDefused;
	bool m_bHasExploded;
	float32 m_flTimerLength;
	bool m_bBeingDefused;
	float32 m_bTriggerWarning;
	float32 m_bExplodeWarning;
	bool m_bC4Activated;
	bool m_bTenSecWarning;
	float32 m_flDefuseLength;
	GameTime_t m_flDefuseCountDown;
	bool m_bBombDefused;
	CHandle< C_CSPlayerPawn > m_hBombDefuser;
	CHandle< C_BaseEntity > m_hControlPanel;
	C_AttributeContainer m_AttributeManager;
	CHandle< C_Multimeter > m_hDefuserMultimeter;
	GameTime_t m_flNextRadarFlashTime;
	bool m_bRadarFlash;
	CHandle< C_CSPlayerPawn > m_pBombDefuser;
	GameTime_t m_fLastDefuseTime;
	CBasePlayerController* m_pPredictionOwner;
	Vector m_vecC4ExplodeSpectatePos;
	QAngle m_vecC4ExplodeSpectateAng;
	float32 m_flC4ExplodeSpectateDuration;
}
