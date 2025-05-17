// MNetworkVarNames = "uint32 m_boneIndexAttached"
// MNetworkVarNames = "uint32 m_ragdollAttachedObjectIndex"
// MNetworkVarNames = "Vector m_attachmentPointBoneSpace"
// MNetworkVarNames = "Vector m_attachmentPointRagdollSpace"
class C_RagdollPropAttached : public C_RagdollProp
{
	// MNetworkEnable
	uint32 m_boneIndexAttached;
	// MNetworkEnable
	uint32 m_ragdollAttachedObjectIndex;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	Vector m_attachmentPointBoneSpace;
	// MNetworkEnable
	// MNetworkEncoder = "coord"
	Vector m_attachmentPointRagdollSpace;
	Vector m_vecOffset;
	float32 m_parentTime;
	bool m_bHasParent;
};
