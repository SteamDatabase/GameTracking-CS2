// MNetworkIncludeByName = "m_bClientSideRagdoll"
// MNetworkVarNames = "bool m_bInitiallyPopulateInterpHistory"
// MNetworkVarNames = "bool m_bAnimGraphUpdateEnabled"
// MNetworkVarNames = "Vector m_vecForce"
// MNetworkVarNames = "int32 m_nForceBone"
// MNetworkVarNames = "PhysicsRagdollPose_t m_RagdollPose"
// MNetworkVarNames = "bool m_bRagdollEnabled"
// MNetworkVarNames = "bool m_bRagdollClientSide"
class CBaseAnimGraph : public CBaseModelEntity
{
	// MSaveOpsForField (UNKNOWN FOR PARSER)
	CAnimGraphControllerManager m_graphControllerManager;
	// MSaveOpsForField (UNKNOWN FOR PARSER)
	CAnimGraphControllerBase* m_pMainGraphController;
	// MNetworkEnable
	bool m_bInitiallyPopulateInterpHistory;
	// MSaveOpsForField (UNKNOWN FOR PARSER)
	IChoreoServices* m_pChoreoServices;
	// MNetworkEnable
	bool m_bAnimGraphUpdateEnabled;
	float32 m_flMaxSlopeDistance;
	// MNotSaved
	VectorWS m_vLastSlopeCheckPos;
	uint32 m_nAnimGraphUpdateId;
	// MNotSaved
	bool m_bAnimationUpdateScheduled;
	// MNetworkEnable
	// MNotSaved
	Vector m_vecForce;
	// MNetworkEnable
	// MNotSaved
	int32 m_nForceBone;
	// MNetworkEnable
	PhysicsRagdollPose_t m_RagdollPose;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnClientRagdollEnabledChanged"
	bool m_bRagdollEnabled;
	// MNetworkEnable
	// MNetworkChangeCallback = "OnClientRagdollChanged"
	// MNotSaved
	bool m_bRagdollClientSide;
	CTransform m_xParentedRagdollRootInEntitySpace;
};
