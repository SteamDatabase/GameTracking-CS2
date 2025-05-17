class IKTargetSettings_t
{
	// MPropertyFriendlyName = "Target Source"
	// MPropertyAttrChangeCallback (UNKNOWN FOR PARSER)
	IKTargetSource m_TargetSource;
	// MPropertyFriendlyName = "Bone"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	IKBoneNameAndIndex_t m_Bone;
	// MPropertyFriendlyName = "Animgraph Position Parameter"
	// MPropertyAttributeChoiceName = "VectorParameter"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	AnimParamID m_AnimgraphParameterNamePosition;
	// MPropertyFriendlyName = "Animgraph Orientation Parameter"
	// MPropertyAttributeChoiceName = "QuaternionParameter"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	AnimParamID m_AnimgraphParameterNameOrientation;
	// MPropertyFriendlyName = "Target Coords"
	// MPropertyAttrStateCallback (UNKNOWN FOR PARSER)
	IKTargetCoordinateSystem m_TargetCoordSystem;
};
