// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Boolean Switch State"
// MPropertyDescription = "While active, activate a child state based on the results of a boolean condition. Any referenced variables must be marked as observable."
// MPulseEditorCanvasItemSpecKV3 = "{ className = 'IsStateNode' item_factory = 'BooleanSwitchState' }"
class CPulseCell_BooleanSwitchState : public CPulseCell_BaseState
{
	// MPropertyDescription = "Condition to evaluate when any of its dependent values change."
	PulseObservableBoolExpression_t m_Condition;
	CPulse_OutflowConnection m_SubGraph;
	CPulse_OutflowConnection m_WhenTrue;
	CPulse_OutflowConnection m_WhenFalse;
};
