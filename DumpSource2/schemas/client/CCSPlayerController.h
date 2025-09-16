// MNetworkUserGroupProxy = "CCSPlayerController"
// MNetworkUserGroupProxy = "CCSPlayerController"
// MNetworkUserGroupProxy = "CCSPlayerController"
// MNetworkUserGroupProxy = "CCSPlayerController"
// MNetworkVarNames = "CCSPlayerController_InGameMoneyServices * m_pInGameMoneyServices"
// MNetworkVarNames = "CCSPlayerController_InventoryServices * m_pInventoryServices"
// MNetworkVarNames = "CCSPlayerController_ActionTrackingServices * m_pActionTrackingServices"
// MNetworkVarNames = "CCSPlayerController_DamageServices * m_pDamageServices"
// MNetworkVarNames = "uint32 m_iPing"
// MNetworkVarNames = "bool m_bHasCommunicationAbuseMute"
// MNetworkVarNames = "uint32 m_uiCommunicationMuteFlags"
// MNetworkVarNames = "string_t m_szCrosshairCodes"
// MNetworkVarNames = "uint8 m_iPendingTeamNum"
// MNetworkVarNames = "GameTime_t m_flForceTeamTime"
// MNetworkVarNames = "int m_iCompTeammateColor"
// MNetworkVarNames = "bool m_bEverPlayedOnTeam"
// MNetworkVarNames = "string_t m_szClan"
// MNetworkVarNames = "int m_iCoachingTeam"
// MNetworkVarNames = "uint64 m_nPlayerDominated"
// MNetworkVarNames = "uint64 m_nPlayerDominatingMe"
// MNetworkVarNames = "int m_iCompetitiveRanking"
// MNetworkVarNames = "int m_iCompetitiveWins"
// MNetworkVarNames = "int8 m_iCompetitiveRankType"
// MNetworkVarNames = "int m_iCompetitiveRankingPredicted_Win"
// MNetworkVarNames = "int m_iCompetitiveRankingPredicted_Loss"
// MNetworkVarNames = "int m_iCompetitiveRankingPredicted_Tie"
// MNetworkVarNames = "int m_nEndMatchNextMapVote"
// MNetworkVarNames = "uint16 m_unActiveQuestId"
// MNetworkVarNames = "RTime32 m_rtActiveMissionPeriod"
// MNetworkVarNames = "QuestProgress::Reason m_nQuestProgressReason"
// MNetworkVarNames = "uint32 m_unPlayerTvControlFlags"
// MNetworkVarNames = "int m_nDisconnectionTick"
// MNetworkVarNames = "bool m_bControllingBot"
// MNetworkVarNames = "bool m_bHasControlledBotThisRound"
// MNetworkVarNames = "bool m_bCanControlObservedBot"
// MNetworkVarNames = "CHandle< CCSPlayerPawn> m_hPlayerPawn"
// MNetworkVarNames = "CHandle< CCSObserverPawn> m_hObserverPawn"
// MNetworkVarNames = "bool m_bPawnIsAlive"
// MNetworkVarNames = "uint32 m_iPawnHealth"
// MNetworkVarNames = "int m_iPawnArmor"
// MNetworkVarNames = "bool m_bPawnHasDefuser"
// MNetworkVarNames = "bool m_bPawnHasHelmet"
// MNetworkVarNames = "item_definition_index_t m_nPawnCharacterDefIndex"
// MNetworkVarNames = "int m_iPawnLifetimeStart"
// MNetworkVarNames = "int m_iPawnLifetimeEnd"
// MNetworkVarNames = "int m_iPawnBotDifficulty"
// MNetworkVarNames = "CHandle< CCSPlayerController> m_hOriginalControllerOfCurrentPawn"
// MNetworkVarNames = "int32 m_iScore"
// MNetworkVarNames = "uint8 m_recentKillQueue"
// MNetworkVarNames = "uint8 m_nFirstKill"
// MNetworkVarNames = "uint8 m_nKillCount"
// MNetworkVarNames = "bool m_bMvpNoMusic"
// MNetworkVarNames = "int m_eMvpReason"
// MNetworkVarNames = "int m_iMusicKitID"
// MNetworkVarNames = "int m_iMusicKitMVPs"
// MNetworkVarNames = "int m_iMVPs"
// MNetworkVarNames = "bool m_bFireBulletsSeedSynchronized"
class CCSPlayerController : public CBasePlayerController
{
	// MNetworkEnable
	CCSPlayerController_InGameMoneyServices* m_pInGameMoneyServices;
	// MNetworkEnable
	CCSPlayerController_InventoryServices* m_pInventoryServices;
	// MNetworkEnable
	CCSPlayerController_ActionTrackingServices* m_pActionTrackingServices;
	// MNetworkEnable
	CCSPlayerController_DamageServices* m_pDamageServices;
	// MNetworkEnable
	uint32 m_iPing;
	// MNetworkEnable
	bool m_bHasCommunicationAbuseMute;
	// MNetworkEnable
	uint32 m_uiCommunicationMuteFlags;
	// MNetworkEnable
	CUtlSymbolLarge m_szCrosshairCodes;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnPendingTeamChanged"
	uint8 m_iPendingTeamNum;
	// MNetworkEnable
	GameTime_t m_flForceTeamTime;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnCompTeammateColorChanged"
	int32 m_iCompTeammateColor;
	// MNetworkEnable
	bool m_bEverPlayedOnTeam;
	GameTime_t m_flPreviousForceJoinTeamTime;
	// MNetworkEnable
	CUtlSymbolLarge m_szClan;
	CUtlString m_sSanitizedPlayerName;
	// MNetworkEnable
	int32 m_iCoachingTeam;
	// MNetworkEnable
	uint64 m_nPlayerDominated;
	// MNetworkEnable
	uint64 m_nPlayerDominatingMe;
	// MNetworkEnable
	int32 m_iCompetitiveRanking;
	// MNetworkEnable
	int32 m_iCompetitiveWins;
	// MNetworkEnable
	int8 m_iCompetitiveRankType;
	// MNetworkEnable
	int32 m_iCompetitiveRankingPredicted_Win;
	// MNetworkEnable
	int32 m_iCompetitiveRankingPredicted_Loss;
	// MNetworkEnable
	int32 m_iCompetitiveRankingPredicted_Tie;
	// MNetworkEnable
	int32 m_nEndMatchNextMapVote;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	uint16 m_unActiveQuestId;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	uint32 m_rtActiveMissionPeriod;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	QuestProgress::Reason m_nQuestProgressReason;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	uint32 m_unPlayerTvControlFlags;
	int32 m_iDraftIndex;
	uint32 m_msQueuedModeDisconnectionTimestamp;
	uint32 m_uiAbandonRecordedReason;
	uint32 m_eNetworkDisconnectionReason;
	bool m_bCannotBeKicked;
	bool m_bEverFullyConnected;
	bool m_bAbandonAllowsSurrender;
	bool m_bAbandonOffersInstantSurrender;
	bool m_bDisconnection1MinWarningPrinted;
	bool m_bScoreReported;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	int32 m_nDisconnectionTick;
	// MNetworkEnable
	bool m_bControllingBot;
	// MNetworkEnable
	bool m_bHasControlledBotThisRound;
	bool m_bHasBeenControlledByPlayerThisRound;
	int32 m_nBotsControlledThisRound;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	bool m_bCanControlObservedBot;
	// MNetworkEnable
	CHandle< C_CSPlayerPawn > m_hPlayerPawn;
	// MNetworkEnable
	CHandle< C_CSObserverPawn > m_hObserverPawn;
	// MNetworkEnable
	bool m_bPawnIsAlive;
	// MNetworkEnable
	// MNetworkUserGroup = "TeammateAndSpectatorExclusive"
	uint32 m_iPawnHealth;
	// MNetworkEnable
	// MNetworkUserGroup = "TeammateAndSpectatorExclusive"
	int32 m_iPawnArmor;
	// MNetworkEnable
	// MNetworkUserGroup = "TeammateAndSpectatorExclusive"
	bool m_bPawnHasDefuser;
	// MNetworkEnable
	// MNetworkUserGroup = "TeammateAndSpectatorExclusive"
	bool m_bPawnHasHelmet;
	// MNetworkEnable
	uint16 m_nPawnCharacterDefIndex;
	// MNetworkEnable
	int32 m_iPawnLifetimeStart;
	// MNetworkEnable
	int32 m_iPawnLifetimeEnd;
	// MNetworkEnable
	int32 m_iPawnBotDifficulty;
	// MNetworkEnable
	CHandle< CCSPlayerController > m_hOriginalControllerOfCurrentPawn;
	// MNetworkEnable
	int32 m_iScore;
	// MNetworkEnable
	uint8[8] m_recentKillQueue;
	// MNetworkEnable
	uint8 m_nFirstKill;
	// MNetworkEnable
	uint8 m_nKillCount;
	// MNetworkEnable
	bool m_bMvpNoMusic;
	// MNetworkEnable
	int32 m_eMvpReason;
	// MNetworkEnable
	int32 m_iMusicKitID;
	// MNetworkEnable
	int32 m_iMusicKitMVPs;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnMVPCountChanged"
	int32 m_iMVPs;
	bool m_bIsPlayerNameDirty;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	bool m_bFireBulletsSeedSynchronized;
};
