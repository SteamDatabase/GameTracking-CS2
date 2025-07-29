// MNetworkVarNames = "CTransform m_Transforms"
// MNetworkVarNames = "EHANDLE m_hOwner"
class PhysicsRagdollPose_t
{
	// MNetworkEnable
	// MNetworkChangeCallback = "OnTransformChanged"
	C_NetworkUtlVectorBase< CTransform > m_Transforms;
	// MNetworkEnable
	CHandle< C_BaseEntity > m_hOwner;
	bool m_bSetFromDebugHistory;
};
