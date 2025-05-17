// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "BaseDomain"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Limit Count"
// MPropertyDescription = "Skip this node after the limit. Check Type does not apply, the limit will always be checked."
// MPulseRequirementPass (UNKNOWN FOR PARSER)
// MPulseRequirementSummaryExpr (UNKNOWN FOR PARSER)
class CPulseCell_LimitCount : public CPulseCell_BaseRequirement
{
	// MPropertyFlattenIntoParentRow
	int32 m_nLimitCount;
};
