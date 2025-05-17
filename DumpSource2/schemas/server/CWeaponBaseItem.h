// MNetworkVarNames = "CountdownTimer m_SequenceCompleteTimer"
// MNetworkVarNames = "bool m_bRedraw"
class CWeaponBaseItem : public CCSWeaponBase
{
	// MNetworkEnable
	CountdownTimer m_SequenceCompleteTimer;
	// MNetworkEnable
	bool m_bRedraw;
};
