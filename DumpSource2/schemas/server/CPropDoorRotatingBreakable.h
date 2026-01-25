class CPropDoorRotatingBreakable : public CPropDoorRotating
{
	// MNotSaved
	bool m_bBreakable;
	// MNotSaved
	bool m_isAbleToCloseAreaPortals;
	// MNotSaved
	int32 m_currentDamageState;
	// MNotSaved
	CUtlVector< CUtlSymbolLarge > m_damageStates;
};
