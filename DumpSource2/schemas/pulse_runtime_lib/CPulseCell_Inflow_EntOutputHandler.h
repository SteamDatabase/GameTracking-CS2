// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Inflow_EntOutputHandler : public CPulseCell_Inflow_BaseEntrypoint
{
	CUtlSymbolLarge m_SourceEntity;
	CUtlSymbolLarge m_SourceOutput;
	CUtlSymbolLarge m_TargetInput;
	CPulseValueFullType m_ExpectedParamType;
};
