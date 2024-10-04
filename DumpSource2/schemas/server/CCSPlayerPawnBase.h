class CCSPlayerPawnBase : public CBasePlayerPawn
{
	CTouchExpansionComponent m_CTouchExpansionComponent;
	CCSPlayer_PingServices* m_pPingServices;
	CPlayer_ViewModelServices* m_pViewModelServices;
	GameTime_t m_blindUntilTime;
	GameTime_t m_blindStartTime;
	CSPlayerState m_iPlayerState;
	bool m_bRespawning;
	GameTime_t m_fImmuneToGunGameDamageTime;
	bool m_bGunGameImmunity;
	float32 m_fMolotovDamageTime;
	bool m_bHasMovedSinceSpawn;
	int32 m_iNumSpawns;
	float32 m_flIdleTimeSinceLastAction;
	float32 m_fNextRadarUpdateTime;
	float32 m_flFlashDuration;
	float32 m_flFlashMaxAlpha;
	float32 m_flProgressBarStartTime;
	int32 m_iProgressBarDuration;
	QAngle m_angEyeAngles;
	bool m_wasNotKilledNaturally;
	bool m_bCommittingSuicideOnTeamChange;
	CHandle< CCSPlayerController > m_hOriginalController;
};
