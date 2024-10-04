class CVoteController : public CBaseEntity
{
	int32 m_iActiveIssueIndex;
	int32 m_iOnlyTeamToVote;
	int32[5] m_nVoteOptionCount;
	int32 m_nPotentialVotes;
	bool m_bIsYesNoVote;
	CountdownTimer m_acceptingVotesTimer;
	CountdownTimer m_executeCommandTimer;
	CountdownTimer m_resetVoteTimer;
	int32[64] m_nVotesCast;
	CPlayerSlot m_playerHoldingVote;
	CPlayerSlot m_playerOverrideForVote;
	int32 m_nHighestCountIndex;
	CUtlVector< CBaseIssue* > m_potentialIssues;
	CUtlVector< char* > m_VoteOptions;
}
