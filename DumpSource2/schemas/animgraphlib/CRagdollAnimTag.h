// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Ragdoll Tag"
class CRagdollAnimTag : public CAnimTagBase
{
	// MPropertyFriendlyName = "Pose Control"
	AnimPoseControl m_nPoseControl;
	// MPropertyFriendlyName = "Frequency"
	// MPropertyAttributeRange = "0 30"
	float32 m_flFrequency;
	// MPropertyFriendlyName = "Damping Ratio"
	// MPropertyAttributeRange = "0 2"
	float32 m_flDampingRatio;
	// MPropertyFriendlyName = "Decay Duration"
	// MPropertyAttributeRange = "-1 1000"
	float32 m_flDecayDuration;
	// MPropertyFriendlyName = "Decay Bias"
	// MPropertyAttributeRange = "0 1"
	float32 m_flDecayBias;
	// MPropertyFriendlyName = "Destroy"
	bool m_bDestroy;
};
