// MGetKV3ClassDefaults = {
//	"m_nMutatorCondition": "COMP_MAT_MUTATOR_CONDITION_INPUT_CONTAINER_EXISTS",
//	"m_strMutatorConditionContainerName": "",
//	"m_strMutatorConditionContainerVarName": "",
//	"m_strMutatorConditionContainerVarValue": "",
//	"m_bPassWhenTrue": true
//}
// MPropertyElementNameFn (UNKNOWN FOR PARSER)
class CompMatMutatorCondition_t
{
	// MPropertyAutoRebuildOnChange
	// MPropertyFriendlyName = "Condition"
	CompMatPropertyMutatorConditionType_t m_nMutatorCondition;
	// MPropertyFriendlyName = "Container Name"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strMutatorConditionContainerName;
	// MPropertyFriendlyName = "Variable Name"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strMutatorConditionContainerVarName;
	// MPropertyFriendlyName = "Variable Value"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	CUtlString m_strMutatorConditionContainerVarValue;
	// MPropertyFriendlyName = "Pass when True"
	bool m_bPassWhenTrue;
};
