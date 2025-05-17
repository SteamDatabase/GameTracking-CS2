// MNetworkVarNames = "VPhysicsCollisionAttribute_t m_collisionAttribute"
// MNetworkVarNames = "Vector m_vecMins"
// MNetworkVarNames = "Vector m_vecMaxs"
// MNetworkVarNames = "uint8 m_usSolidFlags"
// MNetworkVarNames = "SolidType_t m_nSolidType"
// MNetworkVarNames = "uint8 m_triggerBloat"
// MNetworkVarNames = "SurroundingBoundsType_t m_nSurroundType"
// MNetworkVarNames = "uint8 m_CollisionGroup"
// MNetworkVarNames = "uint8 m_nEnablePhysics"
// MNetworkVarNames = "Vector m_vecSpecifiedSurroundingMins"
// MNetworkVarNames = "Vector m_vecSpecifiedSurroundingMaxs"
// MNetworkVarNames = "Vector m_vCapsuleCenter1"
// MNetworkVarNames = "Vector m_vCapsuleCenter2"
// MNetworkVarNames = "float m_flCapsuleRadius"
class CCollisionProperty
{
	// MNetworkEnable
	// MNetworkChangeCallback = "CollisionAttributeChanged"
	VPhysicsCollisionAttribute_t m_collisionAttribute;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnUpdateOBB"
	Vector m_vecMins;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnUpdateOBB"
	Vector m_vecMaxs;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnUpdateSolidFlags"
	uint8 m_usSolidFlags;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnUpdateSolidType"
	SolidType_t m_nSolidType;
	// MNetworkEnable
	// MNetworkChangeCallback = "MarkSurroundingBoundsDirty"
	uint8 m_triggerBloat;
	// MNetworkEnable
	// MNetworkChangeCallback = "MarkSurroundingBoundsDirty"
	SurroundingBoundsType_t m_nSurroundType;
	// MNetworkEnable
	uint8 m_CollisionGroup;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnUpdateEnablePhysics"
	uint8 m_nEnablePhysics;
	float32 m_flBoundingRadius;
	// MNetworkEnable
	// MNetworkChangeCallback = "MarkSurroundingBoundsDirty"
	Vector m_vecSpecifiedSurroundingMins;
	// MNetworkEnable
	// MNetworkChangeCallback = "MarkSurroundingBoundsDirty"
	Vector m_vecSpecifiedSurroundingMaxs;
	Vector m_vecSurroundingMaxs;
	Vector m_vecSurroundingMins;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnUpdateCapsule"
	Vector m_vCapsuleCenter1;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnUpdateCapsule"
	Vector m_vCapsuleCenter2;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnUpdateCapsule"
	float32 m_flCapsuleRadius;
};
