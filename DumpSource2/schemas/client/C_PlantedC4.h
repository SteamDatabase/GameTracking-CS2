// MNetworkVarNames = "bool m_bBombTicking"
// MNetworkVarNames = "int m_nBombSite"
// MNetworkVarNames = "int m_nSourceSoundscapeHash"
// MNetworkVarNames = "EntitySpottedState_t m_entitySpottedState"
// MNetworkVarNames = "GameTime_t m_flC4Blow"
// MNetworkVarNames = "bool m_bCannotBeDefused"
// MNetworkVarNames = "bool m_bHasExploded"
// MNetworkVarNames = "float m_flTimerLength"
// MNetworkVarNames = "bool m_bBeingDefused"
// MNetworkVarNames = "float m_flDefuseLength"
// MNetworkVarNames = "GameTime_t m_flDefuseCountDown"
// MNetworkVarNames = "bool m_bBombDefused"
// MNetworkVarNames = "CHandle< CCSPlayerPawn> m_hBombDefuser"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hControlPanel"
// MNetworkVarNames = "CAttributeContainer m_AttributeManager"
class C_PlantedC4 : public CBaseAnimGraph
{
	// MNetworkEnable
	bool m_bBombTicking;
	// MNetworkEnable
	int32 m_nBombSite;
	// MNetworkEnable
	int32 m_nSourceSoundscapeHash;
	// MNetworkEnable
	EntitySpottedState_t m_entitySpottedState;
	GameTime_t m_flNextGlow;
	GameTime_t m_flNextBeep;
	// MNetworkEnable
	GameTime_t m_flC4Blow;
	// MNetworkEnable
	bool m_bCannotBeDefused;
	// MNetworkEnable
	bool m_bHasExploded;
	// MNetworkEnable
	float32 m_flTimerLength;
	// MNetworkEnable
	bool m_bBeingDefused;
	float32 m_bTriggerWarning;
	float32 m_bExplodeWarning;
	bool m_bC4Activated;
	bool m_bTenSecWarning;
	// MNetworkEnable
	float32 m_flDefuseLength;
	// MNetworkEnable
	GameTime_t m_flDefuseCountDown;
	// MNetworkEnable
	bool m_bBombDefused;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnDefuserChanged"
	CHandle< C_CSPlayerPawn > m_hBombDefuser;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hControlPanel;
	// MNetworkEnable
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
};
