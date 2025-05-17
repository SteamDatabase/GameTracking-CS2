// MNetworkVarNames = "uint32 m_boneIndexAttached"
// MNetworkVarNames = "uint32 m_ragdollAttachedObjectIndex"
// MNetworkVarNames = "Vector m_attachmentPointBoneSpace"
// MNetworkVarNames = "Vector m_attachmentPointRagdollSpace"
class CRagdollPropAttached : public CRagdollProp
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
	bool m_bShouldDetach;
	bool m_bShouldDeleteAttachedActivationRecord;
};
