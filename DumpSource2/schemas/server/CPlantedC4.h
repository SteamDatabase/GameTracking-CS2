class CPlantedC4 : public CBaseAnimGraph
{
	bool m_bBombTicking;
	GameTime_t m_flC4Blow;
	int32 m_nBombSite;
	int32 m_nSourceSoundscapeHash;
	CAttributeContainer m_AttributeManager;
	CEntityIOOutput m_OnBombDefused;
	CEntityIOOutput m_OnBombBeginDefuse;
	CEntityIOOutput m_OnBombDefuseAborted;
	bool m_bCannotBeDefused;
	EntitySpottedState_t m_entitySpottedState;
	int32 m_nSpotRules;
	bool m_bTrainingPlacedByPlayer;
	bool m_bHasExploded;
	float32 m_flTimerLength;
	bool m_bBeingDefused;
	GameTime_t m_fLastDefuseTime;
	float32 m_flDefuseLength;
	GameTime_t m_flDefuseCountDown;
	bool m_bBombDefused;
	CHandle< CCSPlayerPawn > m_hBombDefuser;
	CHandle< CBaseEntity > m_hControlPanel;
	int32 m_iProgressBarTime;
	bool m_bVoiceAlertFired;
	bool[4] m_bVoiceAlertPlayed;
	GameTime_t m_flNextBotBeepTime;
	QAngle m_angCatchUpToPlayerEye;
	GameTime_t m_flLastSpinDetectionTime;
}
