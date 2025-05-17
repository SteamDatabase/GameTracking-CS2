// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MVDataRoot
class CNavLinkMovementVData
{
	// MPropertyDescription = "Model used by the tools only to populate comboboxes for things like animgraph parameter pickers"
	CResourceNameTyped< CWeakHandle< InfoForResourceTypeCModel > > m_sToolsOnlyOwnerModelName;
	// MPropertyFriendlyName = "Is Interpolated"
	// MPropertyDescription = "Indicates that the animation has a segment that's interpolated. In general using this on navlinks that traverse +/- 50% of the recommended distance should look okay."
	bool m_bIsInterpolated;
	// MPropertyFriendlyName = "Recommended Distance"
	// MPropertyDescription = "Recommended distance this movement traverses"
	uint32 m_unRecommendedDistance;
	// MPropertyFriendlyName = "Animgraph Variables"
	// MPropertyDescription = "List of animgraph variables to use when moving through this navlink. Can include multiple, with different amounts of angular slack. The most permissive animgraph variable that exists on the entity's animgraph will be used,"
	// MPropertyAutoExpandSelf
	CUtlVector< CNavLinkAnimgraphVar > m_vecAnimgraphVars;
};
