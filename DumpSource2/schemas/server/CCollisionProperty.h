class CCollisionProperty
{
	VPhysicsCollisionAttribute_t m_collisionAttribute;
	Vector m_vecMins;
	Vector m_vecMaxs;
	uint8 m_usSolidFlags;
	SolidType_t m_nSolidType;
	uint8 m_triggerBloat;
	SurroundingBoundsType_t m_nSurroundType;
	uint8 m_CollisionGroup;
	uint8 m_nEnablePhysics;
	float32 m_flBoundingRadius;
	Vector m_vecSpecifiedSurroundingMins;
	Vector m_vecSpecifiedSurroundingMaxs;
	Vector m_vecSurroundingMaxs;
	Vector m_vecSurroundingMins;
	Vector m_vCapsuleCenter1;
	Vector m_vCapsuleCenter2;
	float32 m_flCapsuleRadius;
};
