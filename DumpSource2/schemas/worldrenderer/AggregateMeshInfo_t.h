class AggregateMeshInfo_t
{
	uint32 m_nVisClusterMemberOffset;
	uint8 m_nVisClusterMemberCount;
	bool m_bHasTransform;
	int16 m_nDrawCallIndex;
	int16 m_nLODSetupIndex;
	uint8 m_nLODGroupMask;
	Color m_vTintColor;
	ObjectTypeFlags_t m_objectFlags;
	int32 m_nLightProbeVolumePrecomputedHandshake;
};
