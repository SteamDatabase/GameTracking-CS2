enum PulseBestOutflowRules_t : uint32_t
{
	// MPropertyFriendlyName = "Choose Best"
	// MPropertyDescription = "Choose the best outflow with all rules passing, as determined by number of passing rules (specificity)."
	SORT_BY_NUMBER_OF_VALID_CRITERIA = 0,
	// MPropertyFriendlyName = "Choose First"
	// MPropertyDescription = "Choose the first outflow with all rules passing, from left to right"
	SORT_BY_OUTFLOW_INDEX = 1,
};
