// MNetworkVarNames = "uint32 m_boneIndexAttached"
// MNetworkVarNames = "uint32 m_ragdollAttachedObjectIndex"
// MNetworkVarNames = "Vector m_attachmentPointBoneSpace"
// MNetworkVarNames = "Vector m_attachmentPointRagdollSpace"
class C_RagdollPropAttached : public C_RagdollProp
{
	// MNetworkEnable
	// MNotSaved
	uint32 m_boneIndexAttached;
	// MNetworkEnable
	// MNotSaved
	uint32 m_ragdollAttachedObjectIndex;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	// MNotSaved
	Vector m_attachmentPointBoneSpace;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	// MNotSaved
	Vector m_attachmentPointRagdollSpace;
	// MNotSaved
	Vector m_vecOffset;
	// MNotSaved
	float32 m_parentTime;
	// MNotSaved
	bool m_bHasParent;
};
