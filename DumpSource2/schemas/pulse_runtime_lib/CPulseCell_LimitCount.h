// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_LimitCount",
//	"m_nEditorNodeID": -1,
//	"m_nLimitCount": 1
//}
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Limit Count"
// MPropertyDescription = "Skip this node after the limit. Check Type does not apply, the limit will always be checked."
// MPulseRequirementPass (UNKNOWN FOR PARSER)
// MPulseRequirementSummaryExpr = ""Limit Count: " + m_nLimitCount"
class CPulseCell_LimitCount : public CPulseCell_BaseRequirement
{
	// MPropertyFlattenIntoParentRow
	int32 m_nLimitCount;
};
