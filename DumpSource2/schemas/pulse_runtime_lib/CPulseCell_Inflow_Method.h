// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Inflow_Method : public CPulseCell_Inflow_BaseEntrypoint
{
	PulseSymbol_t m_MethodName;
	CUtlString m_Description;
	bool m_bIsPublic;
	CPulseValueFullType m_ReturnType;
	CUtlLeanVector< CPulseRuntimeMethodArg > m_Args;
};
