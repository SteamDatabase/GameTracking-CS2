// MNetworkVarNames = "int m_iActiveIssueIndex"
// MNetworkVarNames = "int m_iOnlyTeamToVote"
// MNetworkVarNames = "int m_nVoteOptionCount"
// MNetworkVarNames = "int m_nPotentialVotes"
// MNetworkVarNames = "bool m_bIsYesNoVote"
class C_VoteController : public C_BaseEntity
{
	// MNetworkEnable
	// MNetworkChangeCallback = "RecvProxy_VoteType"
	int32 m_iActiveIssueIndex;
	// MNetworkEnable
	int32 m_iOnlyTeamToVote;
	// MNetworkEnable
	// MNetworkChangeCallback = "RecvProxy_VoteOption"
	int32[5] m_nVoteOptionCount;
	// MNetworkEnable
	int32 m_nPotentialVotes;
	bool m_bVotesDirty;
	bool m_bTypeDirty;
	// MNetworkEnable
	bool m_bIsYesNoVote;
};
