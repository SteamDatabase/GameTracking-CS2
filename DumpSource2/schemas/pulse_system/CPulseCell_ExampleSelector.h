// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "TestDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Select Example Criteria"
// MPropertyDescription = "Evaluate the requirements of each connected node"
// MPulseCell_WithNoDefaultOutflow
// MPulseEditorHeaderIcon = "tools/images/pulse_editor/requirements.png"
// MPulseEditorCanvasItemSpecKV3 = "{ className='IsControlFlowNode AllOutflowsInSpecialSection IsSelectorNode' create_special_outflows_section=true }"
// MPulseSelectorAllowRequirementCriteria = "CPulseCell_IsRequirementValid"
// MPulseSelectorAllowRequirementCriteria = "CPulseCell_ExampleCriteria"
// MPulseSelectorAllowRequirementCriteria = "CPulseCell_LimitCount"
class CPulseCell_ExampleSelector : public CPulseCell_BaseFlow
{
	PulseSelectorOutflowList_t m_OutflowList;
};
