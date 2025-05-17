// MNetworkVarNames = "int m_iAccount"
// MNetworkVarNames = "int m_iStartAccount"
// MNetworkVarNames = "int m_iTotalCashSpent"
// MNetworkVarNames = "int m_iCashSpentThisRound"
class CCSPlayerController_InGameMoneyServices : public CPlayerControllerComponent
{
	// MNetworkEnable
	int32 m_iAccount;
	// MNetworkEnable
	int32 m_iStartAccount;
	// MNetworkEnable
	int32 m_iTotalCashSpent;
	// MNetworkEnable
	int32 m_iCashSpentThisRound;
};
