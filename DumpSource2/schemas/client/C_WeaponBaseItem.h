// MNetworkVarNames = "CountdownTimer m_SequenceCompleteTimer"
// MNetworkVarNames = "bool m_bRedraw"
class C_WeaponBaseItem : public C_CSWeaponBase
{
	// MNetworkEnable
	CountdownTimer m_SequenceCompleteTimer;
	// MNetworkEnable
	bool m_bRedraw;
};
