class CCSCustomHudLayoutState
{
	bool m_bInputCaptureEnabled;
	C_NetworkUtlVectorBase< HUDPanelHasClass_t > m_vecHasClasses;
	C_NetworkUtlVectorBase< HUDPanelDialogVariableString_t > m_vecDialogVariableStrings;
	CPlayerSlot m_playerSlot;
};
