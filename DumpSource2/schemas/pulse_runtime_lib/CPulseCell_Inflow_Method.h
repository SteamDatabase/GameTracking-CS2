class CPulseCell_Inflow_Method : public CPulseCell_Inflow_BaseEntrypoint
{
	CUtlSymbolLarge m_MethodName;
	CUtlString m_Description;
	bool m_bIsPublic;
	CPulseValueFullType m_ReturnType;
	CUtlLeanVector< CPulseRuntimeMethodArg > m_Args;
};
