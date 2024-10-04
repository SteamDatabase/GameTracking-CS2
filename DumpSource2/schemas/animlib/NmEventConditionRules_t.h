enum NmEventConditionRules_t : uint8_t
{
	LimitSearchToSourceState = 0,
	IgnoreInactiveEvents = 1,
	PreferHighestWeight = 2,
	PreferHighestProgress = 3,
	OperatorOr = 4,
	OperatorAnd = 5,
	SearchOnlyStateEvents = 6,
	SearchOnlyAnimEvents = 7,
	SearchBothStateAndAnimEvents = 8,
};
