class C_MapVetoPickController : public C_BaseEntity
{
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
	int32 m_nPostDataUpdateTick;
	bool m_bDisabledHud;
}
