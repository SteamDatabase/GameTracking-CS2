class C_FuncMonitor : public C_FuncBrush
{
	CUtlString m_targetCamera;
	int32 m_nResolutionEnum;
	bool m_bRenderShadows;
	bool m_bUseUniqueColorTarget;
	CUtlString m_brushModelName;
	CHandle< C_BaseEntity > m_hTargetCamera;
	bool m_bEnabled;
	bool m_bDraw3DSkybox;
}
