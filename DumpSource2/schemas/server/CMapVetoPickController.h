class CMapVetoPickController : public CBaseEntity
{
	bool m_bPlayedIntroVcd;
	bool m_bNeedToPlayFiveSecondsRemaining;
	float64 m_dblPreMatchDraftSequenceTime;
	bool m_bPreMatchDraftStateChanged;
	int32 m_nDraftType;
	int32 m_nTeamWinningCoinToss;
	int32[64] m_nTeamWithFirstChoice;
	int32[7] m_nVoteMapIdsList;
	int32[64] m_nAccountIDs;
	int32[64] m_nMapId0;
	int32[64] m_nMapId1;
	int32[64] m_nMapId2;
	int32[64] m_nMapId3;
	int32[64] m_nMapId4;
	int32[64] m_nMapId5;
	int32[64] m_nStartingSide0;
	int32 m_nCurrentPhase;
	int32 m_nPhaseStartTick;
	int32 m_nPhaseDurationTicks;
	CEntityOutputTemplate< CUtlSymbolLarge > m_OnMapVetoed;
	CEntityOutputTemplate< CUtlSymbolLarge > m_OnMapPicked;
	CEntityOutputTemplate< int32 > m_OnSidesPicked;
	CEntityOutputTemplate< int32 > m_OnNewPhaseStarted;
	CEntityOutputTemplate< int32 > m_OnLevelTransition;
};
