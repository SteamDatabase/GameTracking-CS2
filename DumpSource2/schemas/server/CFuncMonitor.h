class CFuncMonitor : public CFuncBrush
{
	CUtlString m_targetCamera;
	int32 m_nResolutionEnum;
	bool m_bRenderShadows;
	bool m_bUseUniqueColorTarget;
	CUtlString m_brushModelName;
	CHandle< CBaseEntity > m_hTargetCamera;
	bool m_bEnabled;
	bool m_bDraw3DSkybox;
	bool m_bStartEnabled;
}
