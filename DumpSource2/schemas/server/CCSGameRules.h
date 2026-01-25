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
class CCSGameRules : public CTeamplayRules
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
	bool m_bHasHostageBeenTouched;
	GameTime_t m_flIntermissionStartTime;
	GameTime_t m_flIntermissionEndTime;
	bool m_bLevelInitialized;
	int32 m_iTotalRoundsPlayed;
	int32 m_iUnBalancedRounds;
	bool m_endMatchOnRoundReset;
	bool m_endMatchOnThink;
	int32 m_iNumTerrorist;
	int32 m_iNumCT;
	int32 m_iNumSpawnableTerrorist;
	int32 m_iNumSpawnableCT;
	CUtlVector< int32 > m_arrSelectedHostageSpawnIndices;
	int32 m_nSpawnPointsRandomSeed;
	bool m_bFirstConnected;
	bool m_bCompleteReset;
	bool m_bPickNewTeamsOnReset;
	bool m_bScrambleTeamsOnRestart;
	bool m_bSwapTeamsOnRestart;
	CUtlVector< int32 > m_nEndMatchTiedVotes;
	bool m_bNeedToAskPlayersForContinueVote;
	uint32 m_numQueuedMatchmakingAccounts;
	float32 m_fAvgPlayerRank;
	char* m_pQueuedMatchmakingReservationString;
	uint32 m_numTotalTournamentDrops;
	uint32 m_numSpectatorsCountMax;
	uint32 m_numSpectatorsCountMaxTV;
	uint32 m_numSpectatorsCountMaxLnk;
	int32 m_nCTsAliveAtFreezetimeEnd;
	int32 m_nTerroristsAliveAtFreezetimeEnd;
	bool m_bForceTeamChangeSilent;
	bool m_bLoadingRoundBackupData;
	int32 m_nMatchInfoShowType;
	float32 m_flMatchInfoDecidedTime;
	int32 mTeamDMLastWinningTeamNumber;
	float32 mTeamDMLastThinkTime;
	float32 m_flTeamDMLastAnnouncementTime;
	int32 m_iAccountTerrorist;
	int32 m_iAccountCT;
	int32 m_iSpawnPointCount_Terrorist;
	int32 m_iSpawnPointCount_CT;
	int32 m_iMaxNumTerrorists;
	int32 m_iMaxNumCTs;
	int32 m_iLoserBonusMostRecentTeam;
	float32 m_tmNextPeriodicThink;
	bool m_bVoiceWonMatchBragFired;
	float32 m_fWarmupNextChatNoticeTime;
	int32 m_iHostagesRescued;
	int32 m_iHostagesTouched;
	float32 m_flNextHostageAnnouncement;
	bool m_bNoTerroristsKilled;
	bool m_bNoCTsKilled;
	bool m_bNoEnemiesKilled;
	bool m_bCanDonateWeapons;
	float32 m_firstKillTime;
	float32 m_firstBloodTime;
	bool m_hostageWasInjured;
	bool m_hostageWasKilled;
	bool m_bVoteCalled;
	bool m_bServerVoteOnReset;
	float32 m_flVoteCheckThrottle;
	bool m_bBuyTimeEnded;
	int32 m_nLastFreezeEndBeep;
	bool m_bTargetBombed;
	bool m_bBombDefused;
	bool m_bMapHasBombZone;
	Vector m_vecMainCTSpawnPos;
	CUtlVector< CHandle< SpawnPoint > > m_CTSpawnPointsMasterList;
	CUtlVector< CHandle< SpawnPoint > > m_TerroristSpawnPointsMasterList;
	bool m_bRespawningAllRespawnablePlayers;
	int32 m_iNextCTSpawnPoint;
	float32 m_flCTSpawnPointUsedTime;
	int32 m_iNextTerroristSpawnPoint;
	float32 m_flTerroristSpawnPointUsedTime;
	CUtlVector< CHandle< SpawnPoint > > m_CTSpawnPoints;
	CUtlVector< CHandle< SpawnPoint > > m_TerroristSpawnPoints;
	bool m_bIsUnreservedGameServer;
	float32 m_fAutobalanceDisplayTime;
	bool m_bAllowWeaponSwitch;
	bool m_bRoundTimeWarningTriggered;
	GameTime_t m_phaseChangeAnnouncementTime;
	float32 m_fNextUpdateTeamClanNamesTime;
	GameTime_t m_flLastThinkTime;
	float32 m_fAccumulatedRoundOffDamage;
	int32 m_nShorthandedBonusLastEvalRound;
	// MNetworkEnable
	int32 m_nMatchAbortedEarlyReason;
	bool m_bHasTriggeredRoundStartMusic;
	bool m_bSwitchingTeamsAtRoundReset;
	// MNetworkEnable
	// MNetworkPolymorphic
	CCSGameModeRules* m_pGameModeRules;
	KeyValues3 m_BtGlobalBlackboard;
	CHandle< CBaseEntity > m_hPlayerResource;
	// MNetworkEnable
	CRetakeGameRules m_RetakeRules;
	CUtlVector< int32 >[4] m_arrTeamUniqueKillWeaponsMatch;
	bool[4] m_bTeamLastKillUsedUniqueWeaponMatch;
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
	GameTime_t m_fTeamIntroPeriodEnd;
	bool m_bPlayedTeamIntroVO;
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
