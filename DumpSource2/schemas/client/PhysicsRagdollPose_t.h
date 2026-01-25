// MNetworkVarNames = "CTransform m_Transforms"
// MNetworkVarNames = "EHANDLE m_hOwner"
class PhysicsRagdollPose_t
{
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	// MNetworkChangeCallback = "OnTransformChanged"
	C_NetworkUtlVectorBase< CTransform > m_Transforms;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hOwner;
	// MNotSaved
	bool m_bSetFromDebugHistory;
};
