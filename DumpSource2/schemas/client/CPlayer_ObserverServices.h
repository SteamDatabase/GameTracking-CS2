// MNetworkVarNames = "uint8 m_iObserverMode"
// MNetworkVarNames = "CHandle< CBaseEntity> m_hObserverTarget"
class CPlayer_ObserverServices : public CPlayerPawnComponent
{
	// MNetworkEnable
	// MNetworkChangeCallback = "OnObserverModeChanged"
	uint8 m_iObserverMode;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnObserverTargetChanged"
	CHandle< C_BaseEntity > m_hObserverTarget;
	ObserverMode_t m_iObserverLastMode;
	bool m_bForcedObserverMode;
	// MNotSaved
	float32 m_flObserverChaseDistance;
	// MNotSaved
	GameTime_t m_flObserverChaseDistanceCalcTime;
};
