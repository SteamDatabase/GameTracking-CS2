// MNetworkVarNames = "int m_iActiveIssueIndex"
// MNetworkVarNames = "int m_iOnlyTeamToVote"
// MNetworkVarNames = "int m_nVoteOptionCount"
// MNetworkVarNames = "int m_nPotentialVotes"
// MNetworkVarNames = "bool m_bIsYesNoVote"
class CVoteController : public CBaseEntity
{
	// MNetworkEnable
	int32 m_iActiveIssueIndex;
	// MNetworkEnable
	int32 m_iOnlyTeamToVote;
	// MNetworkEnable
	int32[5] m_nVoteOptionCount;
	// MNetworkEnable
	int32 m_nPotentialVotes;
	// MNetworkEnable
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
};
