// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_SelectivelyEnableChildren : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "group ID to affect"
	CParticleCollectionFloatInput m_nChildGroupID;
	// MPropertyFriendlyName = "first child to enable"
	CParticleCollectionFloatInput m_nFirstChild;
	// MPropertyFriendlyName = "# of children to enable"
	CParticleCollectionFloatInput m_nNumChildrenToEnable;
	// MPropertyFriendlyName = "play endcap when children are removed"
	bool m_bPlayEndcapOnStop;
	// MPropertyFriendlyName = "destroy particles immediately when child is removed"
	bool m_bDestroyImmediately;
};
