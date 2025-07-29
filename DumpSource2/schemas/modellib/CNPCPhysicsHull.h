// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MModelGameData
// MFgdHelper = "game_data_list{ key = 'CNPCPhysicsHull' }"
// MFgdHelper = "npcphysicshull{}"
class CNPCPhysicsHull
{
	// MPropertyFriendlyName = "Name"
	// MPropertySuppressField
	CGlobalSymbol m_sName;
	// MPropertyFriendlyName = "Type"
	NPCPhysicsHullType_t m_eType;
	// MPropertySuppressExpr = "m_eType != eGroundCapsule && m_eType != eCenteredCapsule"
	// MPropertyFriendlyName = "Height"
	float32 m_flCapsuleHeight;
	// MPropertySuppressExpr = "m_eType != eGroundCapsule && m_eType != eGenericCapsule && m_eType != eCenteredCapsule"
	// MPropertyFriendlyName = "Radius"
	float32 m_flCapsuleRadius;
	// MPropertySuppressExpr = "m_eType != eGenericCapsule"
	// MPropertyFriendlyName = "Center 1"
	Vector m_vCapsuleCenter1;
	// MPropertySuppressExpr = "m_eType != eGenericCapsule"
	// MPropertyFriendlyName = "Center 2"
	Vector m_vCapsuleCenter2;
	// MPropertySuppressExpr = "m_eType != eGroundBox"
	// MPropertyFriendlyName = "Height"
	float32 m_flGroundBoxHeight;
	// MPropertySuppressExpr = "m_eType != eGroundBox"
	// MPropertyFriendlyName = "Width"
	float32 m_flGroundBoxWidth;
};
