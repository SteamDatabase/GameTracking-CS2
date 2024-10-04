class C_RagdollProp : public CBaseAnimGraph
{
	C_NetworkUtlVectorBase< Vector > m_ragPos;
	C_NetworkUtlVectorBase< QAngle > m_ragAngles;
	float32 m_flBlendWeight;
	CHandle< C_BaseEntity > m_hRagdollSource;
	AttachmentHandle_t m_iEyeAttachment;
	float32 m_flBlendWeightCurrent;
	CUtlVector< int32 > m_parentPhysicsBoneIndices;
	CUtlVector< int32 > m_worldSpaceBoneComputationOrder;
}
