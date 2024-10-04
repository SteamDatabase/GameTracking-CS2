class C_RagdollPropAttached : public C_RagdollProp
{
	uint32 m_boneIndexAttached;
	uint32 m_ragdollAttachedObjectIndex;
	Vector m_attachmentPointBoneSpace;
	Vector m_attachmentPointRagdollSpace;
	Vector m_vecOffset;
	float32 m_parentTime;
	bool m_bHasParent;
}
