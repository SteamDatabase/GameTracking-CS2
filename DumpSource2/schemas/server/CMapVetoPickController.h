// MNetworkVarNames = "int m_nDraftType"
// MNetworkVarNames = "int m_nTeamWinningCoinToss"
// MNetworkVarNames = "int m_nTeamWithFirstChoice"
// MNetworkVarNames = "int m_nVoteMapIdsList"
// MNetworkVarNames = "int m_nAccountIDs"
// MNetworkVarNames = "int m_nMapId0"
// MNetworkVarNames = "int m_nMapId1"
// MNetworkVarNames = "int m_nMapId2"
// MNetworkVarNames = "int m_nMapId3"
// MNetworkVarNames = "int m_nMapId4"
// MNetworkVarNames = "int m_nMapId5"
// MNetworkVarNames = "int m_nStartingSide0"
// MNetworkVarNames = "int m_nCurrentPhase"
// MNetworkVarNames = "int m_nPhaseStartTick"
// MNetworkVarNames = "int m_nPhaseDurationTicks"
class CMapVetoPickController : public CBaseEntity
{
	bool m_bPlayedIntroVcd;
	bool m_bNeedToPlayFiveSecondsRemaining;
	float64 m_dblPreMatchDraftSequenceTime;
	bool m_bPreMatchDraftStateChanged;
	// MNetworkEnable
	int32 m_nDraftType;
	// MNetworkEnable
	int32 m_nTeamWinningCoinToss;
	// MNetworkEnable
	int32[64] m_nTeamWithFirstChoice;
	// MNetworkEnable
	int32[7] m_nVoteMapIdsList;
	// MNetworkEnable
	int32[64] m_nAccountIDs;
	// MNetworkEnable
	int32[64] m_nMapId0;
	// MNetworkEnable
	int32[64] m_nMapId1;
	// MNetworkEnable
	int32[64] m_nMapId2;
	// MNetworkEnable
	int32[64] m_nMapId3;
	// MNetworkEnable
	int32[64] m_nMapId4;
	// MNetworkEnable
	int32[64] m_nMapId5;
	// MNetworkEnable
	int32[64] m_nStartingSide0;
	// MNetworkEnable
	int32 m_nCurrentPhase;
	// MNetworkEnable
	int32 m_nPhaseStartTick;
	// MNetworkEnable
	int32 m_nPhaseDurationTicks;
	CEntityOutputTemplate< CUtlSymbolLarge > m_OnMapVetoed;
	CEntityOutputTemplate< CUtlSymbolLarge > m_OnMapPicked;
	CEntityOutputTemplate< int32 > m_OnSidesPicked;
	CEntityOutputTemplate< int32 > m_OnNewPhaseStarted;
	CEntityOutputTemplate< int32 > m_OnLevelTransition;
};
