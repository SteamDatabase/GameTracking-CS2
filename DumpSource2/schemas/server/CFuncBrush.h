class CFuncBrush : public CBaseModelEntity
{
	BrushSolidities_e m_iSolidity;
	int32 m_iDisabled;
	bool m_bSolidBsp;
	CUtlSymbolLarge m_iszExcludedClass;
	bool m_bInvertExclusion;
	bool m_bScriptedMovement;
}
