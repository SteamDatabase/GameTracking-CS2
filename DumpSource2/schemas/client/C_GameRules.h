// MNetworkVarNames = "int m_nTotalPausedTicks"
// MNetworkVarNames = "int m_nPauseStartTick"
// MNetworkVarNames = "bool m_bGamePaused"
class C_GameRules
{
	CNetworkVarChainer __m_pChainEntity;
	// MNetworkEnable
	int32 m_nTotalPausedTicks;
	// MNetworkEnable
	int32 m_nPauseStartTick;
	// MNetworkEnable
	bool m_bGamePaused;
};
