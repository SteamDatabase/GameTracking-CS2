class CRagdollPropAttached : public CRagdollProp
{
	uint32 m_boneIndexAttached;
	uint32 m_ragdollAttachedObjectIndex;
	Vector m_attachmentPointBoneSpace;
	Vector m_attachmentPointRagdollSpace;
	bool m_bShouldDetach;
	bool m_bShouldDeleteAttachedActivationRecord;
}
