// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_INIT_ModelCull : public CParticleFunctionInitializer
{
	// MPropertyFriendlyName = "control point number"
	int32 m_nControlPointNumber;
	// MPropertyFriendlyName = "use only bounding box"
	bool m_bBoundBox;
	// MPropertyFriendlyName = "cull outside instead of inside"
	bool m_bCullOutside;
	// MPropertyFriendlyName = "use bones instead of hitboxes"
	bool m_bUseBones;
	// MPropertyFriendlyName = "hitbox set"
	char[128] m_HitboxSetName;
};
