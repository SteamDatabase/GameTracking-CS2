class CLogicBranchList : public CLogicalEntity
{
	CUtlSymbolLarge[16] m_nLogicBranchNames;
	CUtlVector< CHandle< CBaseEntity > > m_LogicBranchList;
	CLogicBranchList::LogicBranchListenerLastState_t m_eLastState;
	CEntityIOOutput m_OnAllTrue;
	CEntityIOOutput m_OnAllFalse;
	CEntityIOOutput m_OnMixed;
}
