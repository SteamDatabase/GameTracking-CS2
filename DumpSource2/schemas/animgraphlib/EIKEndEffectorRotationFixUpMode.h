enum EIKEndEffectorRotationFixUpMode : uint32_t
{
	// MPropertyFriendlyName = "None"
	// MPropertyDescription = "However the end effector ends up after the solve, it's rotation will remain unchanged."
	None = 0,
	// MPropertyFriendlyName = "Match Target Orientation"
	// MPropertyDescription = "The targets orientation will be stamped onto the end effector."
	MatchTargetOrientation = 1,
	// MPropertyFriendlyName = "Look At Target Forward"
	// MPropertyDescription = "The targets forward vector will be used to build a look orientation while preserving the rotation of the end effector after the solve as much as possible."
	LookAtTargetForward = 2,
	// MPropertyFriendlyName = "Maintain Parent Orientation"
	// MPropertyDescription = "Use the parent bone's orientation as the end effector's orientation."
	MaintainParentOrientation = 3,
	// MPropertySuppressEnumerator
	Count = 4,
};
