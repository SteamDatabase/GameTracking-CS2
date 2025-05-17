// MNetworkVarNames = "CUtlString m_targetCamera"
// MNetworkVarNames = "int m_nResolutionEnum"
// MNetworkVarNames = "bool m_bRenderShadows"
// MNetworkVarNames = "bool m_bUseUniqueColorTarget"
// MNetworkVarNames = "CUtlString m_brushModelName"
// MNetworkVarNames = "EHANDLE m_hTargetCamera"
// MNetworkVarNames = "bool m_bEnabled"
// MNetworkVarNames = "bool m_bDraw3DSkybox"
class CFuncMonitor : public CFuncBrush
{
	// MNetworkEnable
	CUtlString m_targetCamera;
	// MNetworkEnable
	int32 m_nResolutionEnum;
	// MNetworkEnable
	bool m_bRenderShadows;
	// MNetworkEnable
	bool m_bUseUniqueColorTarget;
	// MNetworkEnable
	CUtlString m_brushModelName;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hTargetCamera;
	// MNetworkEnable
	bool m_bEnabled;
	// MNetworkEnable
	bool m_bDraw3DSkybox;
	bool m_bStartEnabled;
};
