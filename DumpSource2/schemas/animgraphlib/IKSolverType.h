enum IKSolverType : uint32_t
{
	// MPropertyFriendlyName = "Perlin"
	// MPropertyDescription = "Classic perlin 2-bone solver"
	IKSOLVER_Perlin = 0,
	// MPropertyFriendlyName = "Two Bone"
	// MPropertyDescription = "2-bone solver that does not have singularities that Perlin does, and should be used as a default starting point for 2 bone solves."
	IKSOLVER_TwoBone = 1,
	// MPropertyFriendlyName = "FABRIK"
	// MPropertyDescription = ""Forward And Backward Reaching Inverse Kinematics" solver - A solver that can handle any number of bones and works by iteratively solving for the position of each bone in the chain."
	IKSOLVER_Fabrik = 2,
	// MPropertyFriendlyName = "Dog Leg (3-Bone)"
	// MPropertyDescription = "A 3-bone solver that uses two 2-bone solves under the hood to emulate a dog leg."
	IKSOLVER_DogLeg3Bone = 3,
	// MPropertyFriendlyName = "CCD"
	// MPropertyDescription = "Cyclic Coordinate Descent solver - A solver that can handle any number of bones and works by iteratively solving for the rotation of each bone in the chain."
	IKSOLVER_CCD = 4,
	// MPropertySuppressEnumerator
	IKSOLVER_COUNT = 5,
};
