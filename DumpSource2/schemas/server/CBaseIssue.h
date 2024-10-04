class CBaseIssue
{
	char[64] m_szTypeString;
	char[4096] m_szDetailsString;
	int32 m_iNumYesVotes;
	int32 m_iNumNoVotes;
	int32 m_iNumPotentialVotes;
	CVoteController* m_pVoteController;
}
