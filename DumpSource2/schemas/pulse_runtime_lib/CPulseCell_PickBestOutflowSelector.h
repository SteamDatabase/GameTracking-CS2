// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Select Best Exit"
// MPropertyDescription = "Evaluate the requirements of each connected node"
// MPulseCell_WithNoDefaultOutflow
// MPulseEditorHeaderIcon = "tools/images/pulse_editor/requirements.png"
// MPulseEditorCanvasItemSpecKV3 = "{ className='IsControlFlowNode AllOutflowsInSpecialSection IsSelectorNode' create_special_outflows_section=true }"
// MPulseSelectorHasSpecificity
// MPulseSelectorAllowRequirementCriteria = "CPulseCell_IsRequirementValid"
// MPulseSelectorAllowRequirementCriteria = "CPulseCell_LimitCount"
class CPulseCell_PickBestOutflowSelector : public CPulseCell_BaseFlow
{
	PulseBestOutflowRules_t m_nCheckType;
	PulseSelectorOutflowList_t m_OutflowList;
};
