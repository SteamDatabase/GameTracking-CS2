// MNetworkVarNames = "ButtonBitMask_t m_nToggleButtonDownMask"
// MNetworkVarNames = "float32 m_flMaxspeed"
// MNetworkVarNames = "float32 m_arrForceSubtickMoveWhen"
class CPlayer_MovementServices : public CPlayerPawnComponent
{
	int32 m_nImpulse;
	CInButtonState m_nButtons;
	uint64 m_nQueuedButtonDownMask;
	uint64 m_nQueuedButtonChangeMask;
	uint64 m_nButtonDoublePressed;
	uint32[64] m_pButtonPressedCmdNumber;
	uint32 m_nLastCommandNumberProcessed;
	// MNetworkEnable
	// MNetworkUserGroup = "LocalPlayerExclusive"
	uint64 m_nToggleButtonDownMask;
	// MNetworkEnable
	// MNetworkBitCount = 12
	// MNetworkMinValue = 0.000000
	// MNetworkMaxValue = 2048.000000
	// MNetworkEncodeFlags = 1
	float32 m_flMaxspeed;
	// MNetworkEnable
	float32[4] m_arrForceSubtickMoveWhen;
	float32 m_flForwardMove;
	float32 m_flLeftMove;
	float32 m_flUpMove;
	Vector m_vecLastMovementImpulses;
	QAngle m_vecLastFinishTickViewAngles;
	QAngle m_vecOldViewAngles;
};
