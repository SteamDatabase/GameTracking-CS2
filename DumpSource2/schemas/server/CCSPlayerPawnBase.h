// MNetworkVarNames = "CTouchExpansionComponent::Storage_t m_CTouchExpansionComponent"
// MNetworkExcludeByName = "m_flAnimTime"
// MNetworkExcludeByName = "m_flexWeight"
// MNetworkExcludeByUserGroup = "m_flPoseParameter"
// MNetworkExcludeByName = "m_baseLayer.m_hSequence"
// MNetworkExcludeByName = "m_animationController.m_flPlaybackRate"
// MNetworkVarNames = "CCSPlayer_PingServices * m_pPingServices"
// MNetworkVarNames = "CPlayer_ViewModelServices * m_pViewModelServices"
// MNetworkVarNames = "CSPlayerState m_iPlayerState"
// MNetworkVarNames = "GameTime_t m_fImmuneToGunGameDamageTime"
// MNetworkVarNames = "bool m_bGunGameImmunity"
// MNetworkVarNames = "float m_fMolotovDamageTime"
// MNetworkVarNames = "bool m_bHasMovedSinceSpawn"
// MNetworkVarNames = "float m_flFlashDuration"
// MNetworkVarNames = "float m_flFlashMaxAlpha"
// MNetworkVarNames = "float m_flProgressBarStartTime"
// MNetworkVarNames = "int m_iProgressBarDuration"
// MNetworkVarNames = "QAngle m_angEyeAngles"
// MNetworkVarNames = "CHandle< CCSPlayerController> m_hOriginalController"
class CCSPlayerPawnBase : public CBasePlayerPawn
{
	// MNetworkEnable
	// MNetworkUserGroup = "CTouchExpansionComponent"
	// MNetworkAlias = "CTouchExpansionComponent"
	// MNetworkTypeAlias = "CTouchExpansionComponent"
	CTouchExpansionComponent m_CTouchExpansionComponent;
	// MNetworkEnable
	CCSPlayer_PingServices* m_pPingServices;
	// MNetworkEnable
	CPlayer_ViewModelServices* m_pViewModelServices;
	GameTime_t m_blindUntilTime;
	GameTime_t m_blindStartTime;
	// MNetworkEnable
	CSPlayerState m_iPlayerState;
	bool m_bRespawning;
	// MNetworkEnable
	GameTime_t m_fImmuneToGunGameDamageTime;
	// MNetworkEnable
	bool m_bGunGameImmunity;
	// MNetworkEnable
	float32 m_fMolotovDamageTime;
	// MNetworkEnable
	bool m_bHasMovedSinceSpawn;
	int32 m_iNumSpawns;
	float32 m_flIdleTimeSinceLastAction;
	float32 m_fNextRadarUpdateTime;
	// MNetworkEnable
	float32 m_flFlashDuration;
	// MNetworkEnable
	float32 m_flFlashMaxAlpha;
	// MNetworkEnable
	float32 m_flProgressBarStartTime;
	// MNetworkEnable
	int32 m_iProgressBarDuration;
	// MNetworkEnable
	// MNetworkEncoder = "qangle_precise"
	// MNetworkPriority = 32
	QAngle m_angEyeAngles;
	bool m_wasNotKilledNaturally;
	bool m_bCommittingSuicideOnTeamChange;
	// MNetworkEnable
	CHandle< CCSPlayerController > m_hOriginalController;
};
