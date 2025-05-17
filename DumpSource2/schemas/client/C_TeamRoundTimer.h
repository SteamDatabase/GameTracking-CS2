// MNetworkVarNames = "bool m_bTimerPaused"
// MNetworkVarNames = "float m_flTimeRemaining"
// MNetworkVarNames = "GameTime_t m_flTimerEndTime"
// MNetworkVarNames = "bool m_bIsDisabled"
// MNetworkVarNames = "bool m_bShowInHUD"
// MNetworkVarNames = "int m_nTimerLength"
// MNetworkVarNames = "int m_nTimerInitialLength"
// MNetworkVarNames = "int m_nTimerMaxLength"
// MNetworkVarNames = "bool m_bAutoCountdown"
// MNetworkVarNames = "int m_nSetupTimeLength"
// MNetworkVarNames = "int m_nState"
// MNetworkVarNames = "bool m_bStartPaused"
// MNetworkVarNames = "bool m_bInCaptureWatchState"
// MNetworkVarNames = "float m_flTotalTime"
// MNetworkVarNames = "bool m_bStopWatchTimer"
class C_TeamRoundTimer : public C_BaseEntity
{
	// MNetworkEnable
	// MNetworkChangeCallback = "OnTimerPaused"
	bool m_bTimerPaused;
	// MNetworkEnable
	float32 m_flTimeRemaining;
	// MNetworkEnable
	GameTime_t m_flTimerEndTime;
	// MNetworkEnable
	bool m_bIsDisabled;
	// MNetworkEnable
	bool m_bShowInHUD;
	// MNetworkEnable
	int32 m_nTimerLength;
	// MNetworkEnable
	int32 m_nTimerInitialLength;
	// MNetworkEnable
	int32 m_nTimerMaxLength;
	// MNetworkEnable
	bool m_bAutoCountdown;
	// MNetworkEnable
	int32 m_nSetupTimeLength;
	// MNetworkEnable
	int32 m_nState;
	// MNetworkEnable
	bool m_bStartPaused;
	// MNetworkEnable
	bool m_bInCaptureWatchState;
	// MNetworkEnable
	float32 m_flTotalTime;
	// MNetworkEnable
	bool m_bStopWatchTimer;
	bool m_bFireFinished;
	bool m_bFire5MinRemain;
	bool m_bFire4MinRemain;
	bool m_bFire3MinRemain;
	bool m_bFire2MinRemain;
	bool m_bFire1MinRemain;
	bool m_bFire30SecRemain;
	bool m_bFire10SecRemain;
	bool m_bFire5SecRemain;
	bool m_bFire4SecRemain;
	bool m_bFire3SecRemain;
	bool m_bFire2SecRemain;
	bool m_bFire1SecRemain;
	int32 m_nOldTimerLength;
	int32 m_nOldTimerState;
};
