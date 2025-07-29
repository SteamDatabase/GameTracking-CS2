// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Wait"
// MPropertyDescription = "Causes each execution cursor to pause at this node for a fixed period of time. Each cursor will wake up and resume execution when the time expires, unless aborted or early-woken."
// MPulseEditorHeaderIcon = "tools/images/pulse_editor/inflow_wait.png"
// MPulseEditorCanvasItemSpecKV3 = "{ className = 'IsWaitNode IsControlFlowNode' }"
class CPulseCell_Inflow_Wait : public CPulseCell_BaseYieldingInflow
{
	CPulse_ResumePoint m_WakeResume;
};
