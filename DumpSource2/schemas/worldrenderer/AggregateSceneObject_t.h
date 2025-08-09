// MGetKV3ClassDefaults = {
//	"m_allFlags": "OBJECT_TYPE_NONE",
//	"m_anyFlags": "OBJECT_TYPE_NONE",
//	"m_nLayer": 0,
//	"m_instanceStream": -1,
//	"m_vertexAlbedoStream": -1,
//	"m_aggregateMeshes":
//	[
//	],
//	"m_lodSetups":
//	[
//	],
//	"m_visClusterMembership":
//	[
//	],
//	"m_fragmentTransforms":
//	[
//	],
//	"m_renderableModel": ""
//}
class AggregateSceneObject_t
{
	ObjectTypeFlags_t m_allFlags;
	ObjectTypeFlags_t m_anyFlags;
	int16 m_nLayer;
	int16 m_instanceStream;
	int16 m_vertexAlbedoStream;
	CUtlVector< AggregateMeshInfo_t > m_aggregateMeshes;
	CUtlVector< AggregateLODSetup_t > m_lodSetups;
	CUtlVector< uint16 > m_visClusterMembership;
	CUtlVector< matrix3x4_t > m_fragmentTransforms;
	CStrongHandle< InfoForResourceTypeCModel > m_renderableModel;
};
