// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
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
