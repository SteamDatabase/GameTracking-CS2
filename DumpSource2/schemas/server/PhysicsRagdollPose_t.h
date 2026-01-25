// MNetworkVarNames = "CTransform m_Transforms"
// MNetworkVarNames = "EHANDLE m_hOwner"
class PhysicsRagdollPose_t
{
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	// MNetworkChangeCallback = "OnTransformChanged"
	CNetworkUtlVectorBase< CTransform > m_Transforms;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hOwner;
	// MNotSaved
	bool m_bSetFromDebugHistory;
};
