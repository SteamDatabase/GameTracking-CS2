class C_VoteController : public C_BaseEntity
{
	int32 m_iActiveIssueIndex;
	int32 m_iOnlyTeamToVote;
	int32[5] m_nVoteOptionCount;
	int32 m_nPotentialVotes;
	bool m_bVotesDirty;
	bool m_bTypeDirty;
	bool m_bIsYesNoVote;
};
