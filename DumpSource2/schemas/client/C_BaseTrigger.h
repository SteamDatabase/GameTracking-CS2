// MNetworkIncludeByName = "m_spawnflags"
// MNetworkVarNames = "bool m_bDisabled"
// MNetworkVarNames = "bool m_bClientSidePredicted"
class C_BaseTrigger : public C_BaseToggle
{
	// MNetworkEnable
	bool m_bDisabled;
	// MNetworkEnable
	bool m_bClientSidePredicted;
};
