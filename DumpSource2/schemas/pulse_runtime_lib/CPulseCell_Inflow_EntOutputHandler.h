// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseCellWithCustomDocNode
class CPulseCell_Inflow_EntOutputHandler : public CPulseCell_Inflow_BaseEntrypoint
{
	PulseSymbol_t m_SourceEntity;
	PulseSymbol_t m_SourceOutput;
	CPulseValueFullType m_ExpectedParamType;
};
