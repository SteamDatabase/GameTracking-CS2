// MNetworkVarNames = "int m_nMatchSeed"
// MNetworkVarNames = "bool m_bBlockersPresent"
// MNetworkVarNames = "bool m_bRoundInProgress"
// MNetworkVarNames = "int m_iFirstSecondHalfRound"
// MNetworkVarNames = "int m_iBombSite"
// MNetworkVarNames = "CHandle< CCSPlayerPawn> m_hBombPlanter"
class CRetakeGameRules
{
	// MNetworkEnable
	int32 m_nMatchSeed;
	// MNetworkEnable
	bool m_bBlockersPresent;
	// MNetworkEnable
	bool m_bRoundInProgress;
	// MNetworkEnable
	int32 m_iFirstSecondHalfRound;
	// MNetworkEnable
	int32 m_iBombSite;
	// MNetworkEnable
	CHandle< CCSPlayerPawn > m_hBombPlanter;
};
