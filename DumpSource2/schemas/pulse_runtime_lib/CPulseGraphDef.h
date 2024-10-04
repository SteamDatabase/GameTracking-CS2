class CPulseGraphDef
{
	CUtlSymbolLarge m_DomainIdentifier;
	CUtlSymbolLarge m_ParentMapName;
	CUtlSymbolLarge m_ParentXmlName;
	CUtlVector< CUtlSymbolLarge > m_vecGameBlackboards;
	CUtlVector< CPulse_Chunk* > m_Chunks;
	CUtlVector< CPulseCell_Base* > m_Cells;
	CUtlVector< CPulse_Variable > m_Vars;
	CUtlVector< CPulse_PublicOutput > m_PublicOutputs;
	CUtlVector< CPulse_InvokeBinding* > m_InvokeBindings;
	CUtlVector< CPulse_CallInfo* > m_CallInfos;
	CUtlVector< CPulse_Constant > m_Constants;
	CUtlVector< CPulse_DomainValue > m_DomainValues;
	CUtlVector< CPulse_BlackboardReference > m_BlackboardReferences;
	CUtlVector< CPulse_OutputConnection* > m_OutputConnections;
}
