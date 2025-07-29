// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPulseFunctionHiddenInTool
// MPulseSelectorAllowRequirementCriteria = "CPulseCell_IsRequirementValid"
// MPulseSelectorAllowRequirementCriteria = "CPulseCell_LimitCount"
class CPulseCell_InlineNodeSkipSelector : public CPulseCell_BaseFlow
{
	PulseDocNodeID_t m_nFlowNodeID;
	bool m_bAnd;
	PulseSelectorOutflowList_t m_PassOutflow;
	CPulse_OutflowConnection m_FailOutflow;
};
