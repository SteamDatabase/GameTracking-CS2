// MNetworkVarNames = "EHANDLE m_hActivator"
class CPointClientUIDialog : public CBaseClientUIEntity
{
	// MNetworkEnable
	// MNetworkChangeCallback = "OnDialogActivatorChanged"
	CHandle< CBaseEntity > m_hActivator;
	bool m_bStartEnabled;
};
