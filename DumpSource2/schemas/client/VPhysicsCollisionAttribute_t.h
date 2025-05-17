// MNetworkVarNames = "uint64 m_nInteractsAs"
// MNetworkVarNames = "uint64 m_nInteractsWith"
// MNetworkVarNames = "uint64 m_nInteractsExclude"
// MNetworkVarNames = "uint32 m_nEntityId"
// MNetworkVarNames = "uint32 m_nOwnerId"
// MNetworkVarNames = "uint16 m_nHierarchyId"
// MNetworkVarNames = "uint8 m_nCollisionGroup"
// MNetworkVarNames = "uint8 m_nCollisionFunctionMask"
class VPhysicsCollisionAttribute_t
{
	// MNetworkEnable
	uint64 m_nInteractsAs;
	// MNetworkEnable
	uint64 m_nInteractsWith;
	// MNetworkEnable
	uint64 m_nInteractsExclude;
	// MNetworkEnable
	uint32 m_nEntityId;
	// MNetworkEnable
	uint32 m_nOwnerId;
	// MNetworkEnable
	uint16 m_nHierarchyId;
	// MNetworkEnable
	uint8 m_nCollisionGroup;
	// MNetworkEnable
	uint8 m_nCollisionFunctionMask;
};
