enum MissingParentInheritBehavior_t : uint32_t
{
	// MPropertyFriendlyName = "Do Nothing"
	MISSING_PARENT_DO_NOTHING = -1,
	// MPropertyFriendlyName = "Kill Particle"
	MISSING_PARENT_KILL = 0,
	// MPropertyFriendlyName = "Use Next Parent Particle"
	MISSING_PARENT_FIND_NEW = 1,
	// MPropertyFriendlyName = "Use New Particle at Same Index if Possible"
	MISSING_PARENT_SAME_INDEX = 2,
};
