// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyElementNameFn (UNKNOWN FOR PARSER)
class CompositeMaterialAssemblyProcedure_t
{
	// MPropertyFriendlyName = "Includes"
	// MPropertyAttributeEditor = "AssetBrowse( vcompmat )"
	CUtlVector< CResourceName > m_vecCompMatIncludes;
	// MPropertyFriendlyName = "Match Filters"
	CUtlVector< CompositeMaterialMatchFilter_t > m_vecMatchFilters;
	// MPropertyFriendlyName = "Composite Inputs"
	CUtlVector< CompositeMaterialInputContainer_t > m_vecCompositeInputContainers;
	// MPropertyFriendlyName = "Property Mutators"
	CUtlVector< CompMatPropertyMutator_t > m_vecPropertyMutators;
};
