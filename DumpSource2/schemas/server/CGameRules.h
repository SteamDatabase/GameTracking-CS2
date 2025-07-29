// MNetworkVarNames = "int m_nTotalPausedTicks"
// MNetworkVarNames = "int m_nPauseStartTick"
// MNetworkVarNames = "bool m_bGamePaused"
class CGameRules
{
	CNetworkVarChainer __m_pChainEntity;
	char[128] m_szQuestName;
	int32 m_nQuestPhase;
	// MNetworkEnable
	int32 m_nTotalPausedTicks;
	// MNetworkEnable
	int32 m_nPauseStartTick;
	// MNetworkEnable
	bool m_bGamePaused;
};
