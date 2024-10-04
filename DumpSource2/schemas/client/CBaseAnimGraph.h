class CBaseAnimGraph : public C_BaseModelEntity
{
	bool m_bInitiallyPopulateInterpHistory;
	bool m_bSuppressAnimEventSounds;
	bool m_bAnimGraphUpdateEnabled;
	float32 m_flMaxSlopeDistance;
	Vector m_vLastSlopeCheckPos;
	bool m_bAnimationUpdateScheduled;
	Vector m_vecForce;
	int32 m_nForceBone;
	CBaseAnimGraph* m_pClientsideRagdoll;
	bool m_bBuiltRagdoll;
	PhysicsRagdollPose_t m_RagdollPose;
	bool m_bRagdollClientSide;
	bool m_bHasAnimatedMaterialAttributes;
};
