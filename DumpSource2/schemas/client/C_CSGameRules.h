// MNetworkVarNames = "bool m_bFreezePeriod"
// MNetworkVarNames = "bool m_bWarmupPeriod"
// MNetworkVarNames = "GameTime_t m_fWarmupPeriodEnd"
// MNetworkVarNames = "GameTime_t m_fWarmupPeriodStart"
// MNetworkVarNames = "bool m_bTerroristTimeOutActive"
// MNetworkVarNames = "bool m_bCTTimeOutActive"
// MNetworkVarNames = "float m_flTerroristTimeOutRemaining"
// MNetworkVarNames = "float m_flCTTimeOutRemaining"
// MNetworkVarNames = "int m_nTerroristTimeOuts"
// MNetworkVarNames = "int m_nCTTimeOuts"
// MNetworkVarNames = "bool m_bTechnicalTimeOut"
// MNetworkVarNames = "bool m_bMatchWaitingForResume"
// MNetworkVarNames = "int m_iFreezeTime"
// MNetworkVarNames = "int m_iRoundTime"
// MNetworkVarNames = "float m_fMatchStartTime"
// MNetworkVarNames = "GameTime_t m_fRoundStartTime"
// MNetworkVarNames = "GameTime_t m_flRestartRoundTime"
// MNetworkVarNames = "bool m_bGameRestart"
// MNetworkVarNames = "float m_flGameStartTime"
// MNetworkVarNames = "float m_timeUntilNextPhaseStarts"
// MNetworkVarNames = "int m_gamePhase"
// MNetworkVarNames = "int m_totalRoundsPlayed"
// MNetworkVarNames = "int m_nRoundsPlayedThisPhase"
// MNetworkVarNames = "int m_nOvertimePlaying"
// MNetworkVarNames = "int m_iHostagesRemaining"
// MNetworkVarNames = "bool m_bAnyHostageReached"
// MNetworkVarNames = "bool m_bMapHasBombTarget"
// MNetworkVarNames = "bool m_bMapHasRescueZone"
// MNetworkVarNames = "bool m_bMapHasBuyZone"
// MNetworkVarNames = "bool m_bIsQueuedMatchmaking"
// MNetworkVarNames = "int m_nQueuedMatchmakingMode"
// MNetworkVarNames = "bool m_bIsValveDS"
// MNetworkVarNames = "bool m_bLogoMap"
// MNetworkVarNames = "bool m_bPlayAllStepSoundsOnServer"
// MNetworkVarNames = "int m_iSpectatorSlotCount"
// MNetworkVarNames = "int m_MatchDevice"
// MNetworkVarNames = "bool m_bHasMatchStarted"
// MNetworkVarNames = "int m_nNextMapInMapgroup"
// MNetworkVarNames = "char m_szTournamentEventName"
// MNetworkVarNames = "char m_szTournamentEventStage"
// MNetworkVarNames = "char m_szMatchStatTxt"
// MNetworkVarNames = "char m_szTournamentPredictionsTxt"
// MNetworkVarNames = "int m_nTournamentPredictionsPct"
// MNetworkVarNames = "GameTime_t m_flCMMItemDropRevealStartTime"
// MNetworkVarNames = "GameTime_t m_flCMMItemDropRevealEndTime"
// MNetworkVarNames = "bool m_bIsDroppingItems"
// MNetworkVarNames = "bool m_bIsQuestEligible"
// MNetworkVarNames = "bool m_bIsHltvActive"
// MNetworkVarNames = "bool m_bBombPlanted"
// MNetworkVarNames = "uint16 m_arrProhibitedItemIndices"
// MNetworkVarNames = "uint32 m_arrTournamentActiveCasterAccounts"
// MNetworkVarNames = "int m_numBestOfMaps"
// MNetworkVarNames = "int m_nHalloweenMaskListSeed"
// MNetworkVarNames = "bool m_bBombDropped"
// MNetworkVarNames = "int m_iRoundWinStatus"
// MNetworkVarNames = "int m_eRoundWinReason"
// MNetworkVarNames = "bool m_bTCantBuy"
// MNetworkVarNames = "bool m_bCTCantBuy"
// MNetworkVarNames = "int m_iMatchStats_RoundResults"
// MNetworkVarNames = "int m_iMatchStats_PlayersAlive_CT"
// MNetworkVarNames = "int m_iMatchStats_PlayersAlive_T"
// MNetworkVarNames = "float m_TeamRespawnWaveTimes"
// MNetworkVarNames = "GameTime_t m_flNextRespawnWave"
// MNetworkVarNames = "Vector m_vMinimapMins"
// MNetworkVarNames = "Vector m_vMinimapMaxs"
// MNetworkVarNames = "float m_MinimapVerticalSectionHeights"
// MNetworkVarNames = "int m_nEndMatchMapGroupVoteTypes"
// MNetworkVarNames = "int m_nEndMatchMapGroupVoteOptions"
// MNetworkVarNames = "int m_nEndMatchMapVoteWinner"
// MNetworkVarNames = "int m_iNumConsecutiveCTLoses"
// MNetworkVarNames = "int m_iNumConsecutiveTerroristLoses"
// MNetworkVarNames = "int m_nMatchAbortedEarlyReason"
// MNetworkVarNames = "CCSGameModeRules * m_pGameModeRules"
// MNetworkVarNames = "CRetakeGameRules m_RetakeRules"
// MNetworkVarNames = "uint8 m_nMatchEndCount"
// MNetworkVarNames = "int m_nTTeamIntroVariant"
// MNetworkVarNames = "int m_nCTTeamIntroVariant"
// MNetworkVarNames = "bool m_bTeamIntroPeriod"
// MNetworkVarNames = "int m_iRoundEndWinnerTeam"
// MNetworkVarNames = "int m_eRoundEndReason"
// MNetworkVarNames = "bool m_bRoundEndShowTimerDefend"
// MNetworkVarNames = "int m_iRoundEndTimerTime"
// MNetworkVarNames = "CUtlString m_sRoundEndFunFactToken"
// MNetworkVarNames = "CPlayerSlot m_iRoundEndFunFactPlayerSlot"
// MNetworkVarNames = "int m_iRoundEndFunFactData1"
// MNetworkVarNames = "int m_iRoundEndFunFactData2"
// MNetworkVarNames = "int m_iRoundEndFunFactData3"
// MNetworkVarNames = "CUtlString m_sRoundEndMessage"
// MNetworkVarNames = "int m_iRoundEndPlayerCount"
// MNetworkVarNames = "bool m_bRoundEndNoMusic"
// MNetworkVarNames = "int m_iRoundEndLegacy"
// MNetworkVarNames = "uint8 m_nRoundEndCount"
// MNetworkVarNames = "int m_iRoundStartRoundNumber"
// MNetworkVarNames = "uint8 m_nRoundStartCount"
class C_CSGameRules : public C_TeamplayRules
{
	// MNetworkEnable
	bool m_bFreezePeriod;
	// MNetworkEnable
	bool m_bWarmupPeriod;
	// MNetworkEnable
	GameTime_t m_fWarmupPeriodEnd;
	// MNetworkEnable
	GameTime_t m_fWarmupPeriodStart;
	// MNetworkEnable
	bool m_bTerroristTimeOutActive;
	// MNetworkEnable
	bool m_bCTTimeOutActive;
	// MNetworkEnable
	float32 m_flTerroristTimeOutRemaining;
	// MNetworkEnable
	float32 m_flCTTimeOutRemaining;
	// MNetworkEnable
	int32 m_nTerroristTimeOuts;
	// MNetworkEnable
	int32 m_nCTTimeOuts;
	// MNetworkEnable
	bool m_bTechnicalTimeOut;
	// MNetworkEnable
	bool m_bMatchWaitingForResume;
	// MNetworkEnable
	int32 m_iFreezeTime;
	// MNetworkEnable
	int32 m_iRoundTime;
	// MNetworkEnable
	float32 m_fMatchStartTime;
	// MNetworkEnable
	GameTime_t m_fRoundStartTime;
	// MNetworkEnable
	GameTime_t m_flRestartRoundTime;
	// MNetworkEnable
	bool m_bGameRestart;
	// MNetworkEnable
	float32 m_flGameStartTime;
	// MNetworkEnable
	float32 m_timeUntilNextPhaseStarts;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnGamePhaseChanged"
	int32 m_gamePhase;
	// MNetworkEnable
	int32 m_totalRoundsPlayed;
	// MNetworkEnable
	int32 m_nRoundsPlayedThisPhase;
	// MNetworkEnable
	int32 m_nOvertimePlaying;
	// MNetworkEnable
	int32 m_iHostagesRemaining;
	// MNetworkEnable
	bool m_bAnyHostageReached;
	// MNetworkEnable
	bool m_bMapHasBombTarget;
	// MNetworkEnable
	bool m_bMapHasRescueZone;
	// MNetworkEnable
	bool m_bMapHasBuyZone;
	// MNetworkEnable
	bool m_bIsQueuedMatchmaking;
	// MNetworkEnable
	int32 m_nQueuedMatchmakingMode;
	// MNetworkEnable
	bool m_bIsValveDS;
	// MNetworkEnable
	bool m_bLogoMap;
	// MNetworkEnable
	bool m_bPlayAllStepSoundsOnServer;
	// MNetworkEnable
	int32 m_iSpectatorSlotCount;
	// MNetworkEnable
	int32 m_MatchDevice;
	// MNetworkEnable
	bool m_bHasMatchStarted;
	// MNetworkEnable
	int32 m_nNextMapInMapgroup;
	// MNetworkEnable
	char[512] m_szTournamentEventName;
	// MNetworkEnable
	char[512] m_szTournamentEventStage;
	// MNetworkEnable
	char[512] m_szMatchStatTxt;
	// MNetworkEnable
	char[512] m_szTournamentPredictionsTxt;
	// MNetworkEnable
	int32 m_nTournamentPredictionsPct;
	// MNetworkEnable
	GameTime_t m_flCMMItemDropRevealStartTime;
	// MNetworkEnable
	GameTime_t m_flCMMItemDropRevealEndTime;
	// MNetworkEnable
	bool m_bIsDroppingItems;
	// MNetworkEnable
	bool m_bIsQuestEligible;
	// MNetworkEnable
	bool m_bIsHltvActive;
	// MNetworkEnable
	bool m_bBombPlanted;
	// MNetworkEnable
	uint16[100] m_arrProhibitedItemIndices;
	// MNetworkEnable
	uint32[4] m_arrTournamentActiveCasterAccounts;
	// MNetworkEnable
	int32 m_numBestOfMaps;
	// MNetworkEnable
	int32 m_nHalloweenMaskListSeed;
	// MNetworkEnable
	bool m_bBombDropped;
	// MNetworkEnable
	int32 m_iRoundWinStatus;
	// MNetworkEnable
	int32 m_eRoundWinReason;
	// MNetworkEnable
	bool m_bTCantBuy;
	// MNetworkEnable
	bool m_bCTCantBuy;
	// MNetworkEnable
	int32[30] m_iMatchStats_RoundResults;
	// MNetworkEnable
	int32[30] m_iMatchStats_PlayersAlive_CT;
	// MNetworkEnable
	int32[30] m_iMatchStats_PlayersAlive_T;
	// MNetworkEnable
	float32[32] m_TeamRespawnWaveTimes;
	// MNetworkEnable
	GameTime_t[32] m_flNextRespawnWave;
	// MNetworkEnable
	Vector m_vMinimapMins;
	// MNetworkEnable
	Vector m_vMinimapMaxs;
	// MNetworkEnable
	float32[8] m_MinimapVerticalSectionHeights;
	uint64 m_ullLocalMatchID;
	// MNetworkEnable
	int32[10] m_nEndMatchMapGroupVoteTypes;
	// MNetworkEnable
	int32[10] m_nEndMatchMapGroupVoteOptions;
	// MNetworkEnable
	int32 m_nEndMatchMapVoteWinner;
	// MNetworkEnable
	int32 m_iNumConsecutiveCTLoses;
	// MNetworkEnable
	int32 m_iNumConsecutiveTerroristLoses;
	// MNetworkEnable
	int32 m_nMatchAbortedEarlyReason;
	bool m_bHasTriggeredRoundStartMusic;
	bool m_bSwitchingTeamsAtRoundReset;
	// MNetworkEnable
	// MNetworkPolymorphic
	CCSGameModeRules* m_pGameModeRules;
	// MNetworkEnable
	C_RetakeGameRules m_RetakeRules;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnMatchEndCountChanged"
	uint8 m_nMatchEndCount;
	// MNetworkEnable
	int32 m_nTTeamIntroVariant;
	// MNetworkEnable
	int32 m_nCTTeamIntroVariant;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnTeamIntroPeriodChanged"
	bool m_bTeamIntroPeriod;
	// MNetworkEnable
	int32 m_iRoundEndWinnerTeam;
	// MNetworkEnable
	int32 m_eRoundEndReason;
	// MNetworkEnable
	bool m_bRoundEndShowTimerDefend;
	// MNetworkEnable
	int32 m_iRoundEndTimerTime;
	// MNetworkEnable
	CUtlString m_sRoundEndFunFactToken;
	// MNetworkEnable
	CPlayerSlot m_iRoundEndFunFactPlayerSlot;
	// MNetworkEnable
	int32 m_iRoundEndFunFactData1;
	// MNetworkEnable
	int32 m_iRoundEndFunFactData2;
	// MNetworkEnable
	int32 m_iRoundEndFunFactData3;
	// MNetworkEnable
	CUtlString m_sRoundEndMessage;
	// MNetworkEnable
	int32 m_iRoundEndPlayerCount;
	// MNetworkEnable
	bool m_bRoundEndNoMusic;
	// MNetworkEnable
	int32 m_iRoundEndLegacy;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnRoundEndCountChanged"
	uint8 m_nRoundEndCount;
	// MNetworkEnable
	int32 m_iRoundStartRoundNumber;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnRoundStartCountChanged"
	uint8 m_nRoundStartCount;
	float64 m_flLastPerfSampleTime;
};
