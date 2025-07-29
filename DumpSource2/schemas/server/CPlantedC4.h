// MNetworkVarNames = "bool m_bBombTicking"
// MNetworkVarNames = "GameTime_t m_flC4Blow"
// MNetworkVarNames = "int m_nBombSite"
// MNetworkVarNames = "int m_nSourceSoundscapeHash"
// MNetworkVarNames = "CAttributeContainer m_AttributeManager"
// MNetworkVarNames = "bool m_bCannotBeDefused"
// MNetworkVarNames = "EntitySpottedState_t m_entitySpottedState"
// MNetworkVarNames = "bool m_bHasExploded"
// MNetworkVarNames = "float m_flTimerLength"
// MNetworkVarNames = "bool m_bBeingDefused"
// MNetworkVarNames = "float m_flDefuseLength"
// MNetworkVarNames = "GameTime_t m_flDefuseCountDown"
// MNetworkVarNames = "bool m_bBombDefused"
// MNetworkVarNames = "CHandle< CCSPlayerPawn> m_hBombDefuser"
class CPlantedC4 : public CBaseAnimGraph
{
	// MNetworkEnable
	bool m_bBombTicking;
	// MNetworkEnable
	GameTime_t m_flC4Blow;
	// MNetworkEnable
	int32 m_nBombSite;
	// MNetworkEnable
	int32 m_nSourceSoundscapeHash;
	// MNetworkEnable
	CAttributeContainer m_AttributeManager;
	CEntityIOOutput m_OnBombDefused;
	CEntityIOOutput m_OnBombBeginDefuse;
	CEntityIOOutput m_OnBombDefuseAborted;
	// MNetworkEnable
	bool m_bCannotBeDefused;
	// MNetworkEnable
	EntitySpottedState_t m_entitySpottedState;
	int32 m_nSpotRules;
	bool m_bTrainingPlacedByPlayer;
	// MNetworkEnable
	bool m_bHasExploded;
	// MNetworkEnable
	float32 m_flTimerLength;
	// MNetworkEnable
	bool m_bBeingDefused;
	GameTime_t m_fLastDefuseTime;
	// MNetworkEnable
	float32 m_flDefuseLength;
	// MNetworkEnable
	GameTime_t m_flDefuseCountDown;
	// MNetworkEnable
	bool m_bBombDefused;
	// MNetworkEnable
	CHandle< CCSPlayerPawn > m_hBombDefuser;
	int32 m_iProgressBarTime;
	bool m_bVoiceAlertFired;
	bool[4] m_bVoiceAlertPlayed;
	GameTime_t m_flNextBotBeepTime;
	QAngle m_angCatchUpToPlayerEye;
	GameTime_t m_flLastSpinDetectionTime;
};
