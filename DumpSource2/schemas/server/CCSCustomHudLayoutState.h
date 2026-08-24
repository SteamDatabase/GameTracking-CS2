class CCSCustomHudLayoutState
{
	bool m_bInputCaptureEnabled;
	CNetworkUtlVectorBase< HUDPanelHasClass_t > m_vecHasClasses;
	CNetworkUtlVectorBase< HUDPanelDialogVariableString_t > m_vecDialogVariableStrings;
	CPlayerSlot m_playerSlot;
};
