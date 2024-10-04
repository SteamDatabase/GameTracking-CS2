class CBaseAnimGraph : public CBaseModelEntity
{
	bool m_bInitiallyPopulateInterpHistory;
	IChoreoServices* m_pChoreoServices;
	bool m_bAnimGraphUpdateEnabled;
	float32 m_flMaxSlopeDistance;
	Vector m_vLastSlopeCheckPos;
	bool m_bAnimationUpdateScheduled;
	Vector m_vecForce;
	int32 m_nForceBone;
	PhysicsRagdollPose_t m_RagdollPose;
	bool m_bRagdollClientSide;
}
