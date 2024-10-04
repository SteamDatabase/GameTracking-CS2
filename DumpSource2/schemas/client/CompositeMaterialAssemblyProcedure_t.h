class CompositeMaterialAssemblyProcedure_t
{
	CUtlVector< CResourceName > m_vecCompMatIncludes;
	CUtlVector< CompositeMaterialMatchFilter_t > m_vecMatchFilters;
	CUtlVector< CompositeMaterialInputContainer_t > m_vecCompositeInputContainers;
	CUtlVector< CompMatPropertyMutator_t > m_vecPropertyMutators;
};
