// MNetworkVarNames = "EHANDLE m_hActivator"
class C_PointClientUIDialog : public C_BaseClientUIEntity
{
	// MNetworkEnable
	// MNetworkChangeCallback = "OnDialogActivatorChanged"
	CHandle< C_BaseEntity > m_hActivator;
	bool m_bStartEnabled;
};
