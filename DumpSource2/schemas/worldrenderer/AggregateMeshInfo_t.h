// MGetKV3ClassDefaults = {
//	"m_nVisClusterMemberOffset": 0,
//	"m_nVisClusterMemberCount": 0,
//	"m_bHasTransform": false,
//	"m_nLODGroupMask": 0,
//	"m_nDrawCallIndex": -1,
//	"m_nLODSetupIndex": -1,
//	"m_vTintColor":
//	[
//		255,
//		255,
//		255
//	],
//	"m_objectFlags": "OBJECT_TYPE_MODEL",
//	"m_nLightProbeVolumePrecomputedHandshake": 0,
//	"m_nInstanceStreamOffset": 0,
//	"m_nVertexAlbedoStreamOffset": 0,
//	"m_instanceStreams": "AGGREGATE_INSTANCE_STREAM_NONE"
//}
class AggregateMeshInfo_t
{
	uint32 m_nVisClusterMemberOffset;
	uint8 m_nVisClusterMemberCount;
	bool m_bHasTransform;
	uint8 m_nLODGroupMask;
	int16 m_nDrawCallIndex;
	int16 m_nLODSetupIndex;
	Color m_vTintColor;
	ObjectTypeFlags_t m_objectFlags;
	int32 m_nLightProbeVolumePrecomputedHandshake;
	uint32 m_nInstanceStreamOffset;
	uint32 m_nVertexAlbedoStreamOffset;
	AggregateInstanceStream_t m_instanceStreams;
};
