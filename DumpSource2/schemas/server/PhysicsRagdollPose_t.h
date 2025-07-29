// MNetworkVarNames = "CTransform m_Transforms"
// MNetworkVarNames = "EHANDLE m_hOwner"
class PhysicsRagdollPose_t
{
	// MNetworkEnable
	// MNetworkChangeCallback = "OnTransformChanged"
	CNetworkUtlVectorBase< CTransform > m_Transforms;
	// MNetworkEnable
	CHandle< CBaseEntity > m_hOwner;
	bool m_bSetFromDebugHistory;
};
