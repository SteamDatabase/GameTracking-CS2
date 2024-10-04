class CPropDoorRotatingBreakable : public CPropDoorRotating
{
	bool m_bBreakable;
	bool m_isAbleToCloseAreaPortals;
	int32 m_currentDamageState;
	CUtlVector< CUtlSymbolLarge > m_damageStates;
}
