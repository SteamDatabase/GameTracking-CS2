// MNetworkVarNames = "int m_nTotalPausedTicks"
// MNetworkVarNames = "int m_nPauseStartTick"
// MNetworkVarNames = "bool m_bGamePaused"
class CGameRules
{
	// MNotSaved
	CNetworkVarChainer __m_pChainEntity;
	char[128] m_szQuestName;
	int32 m_nQuestPhase;
	uint32 m_nLastMatchTime;
	uint64 m_nLastMatchTime_MatchID64;
	// MNetworkEnable
	int32 m_nTotalPausedTicks;
	// MNetworkEnable
	int32 m_nPauseStartTick;
	// MNetworkEnable
	bool m_bGamePaused;
};
