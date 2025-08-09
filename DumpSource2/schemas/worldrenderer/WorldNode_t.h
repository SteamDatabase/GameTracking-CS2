// MGetKV3ClassDefaults = {
//	"m_sceneObjects":
//	[
//	],
//	"m_infoOverlays":
//	[
//	],
//	"m_visClusterMembership":
//	[
//	],
//	"m_aggregateSceneObjects":
//	[
//	],
//	"m_clutterSceneObjects":
//	[
//	],
//	"m_extraVertexStreamOverrides":
//	[
//	],
//	"m_materialOverrides":
//	[
//	],
//	"m_extraVertexStreams":
//	[
//	],
//	"m_aggregateInstanceStreams":
//	[
//	],
//	"m_vertexAlbedoStreams":
//	[
//	],
//	"m_layerNames":
//	[
//	],
//	"m_sceneObjectLayerIndices":
//	[
//	],
//	"m_overlayLayerIndices":
//	[
//	],
//	"m_grassFileName": "",
//	"m_nodeLightingInfo":
//	{
//		"m_nLightmapVersionNumber": 0,
//		"m_nLightmapGameVersionNumber": 0,
//		"m_vLightmapUvScale":
//		[
//			1.000000,
//			1.000000
//		],
//		"m_bHasLightmaps": false,
//		"m_bBakedShadowsGamma20": false,
//		"m_bCompressionEnabled": false,
//		"m_bSHLightmaps": false,
//		"m_nChartPackIterations": 0,
//		"m_nVradQuality": 0,
//		"m_lightMaps":
//		[
//		],
//		"m_bakedShadows":
//		[
//		]
//	},
//	"m_bHasBakedGeometryFlag": false
//}
class WorldNode_t
{
	CUtlVector< SceneObject_t > m_sceneObjects;
	CUtlVector< InfoOverlayData_t > m_infoOverlays;
	CUtlVector< uint16 > m_visClusterMembership;
	CUtlVector< AggregateSceneObject_t > m_aggregateSceneObjects;
	CUtlVector< ClutterSceneObject_t > m_clutterSceneObjects;
	CUtlVector< ExtraVertexStreamOverride_t > m_extraVertexStreamOverrides;
	CUtlVector< MaterialOverride_t > m_materialOverrides;
	CUtlVector< WorldNodeOnDiskBufferData_t > m_extraVertexStreams;
	CUtlVector< AggregateInstanceStreamOnDiskData_t > m_aggregateInstanceStreams;
	CUtlVector< AggregateVertexAlbedoStreamOnDiskData_t > m_vertexAlbedoStreams;
	CUtlVector< CUtlString > m_layerNames;
	CUtlVector< uint8 > m_sceneObjectLayerIndices;
	CUtlVector< uint8 > m_overlayLayerIndices;
	CUtlString m_grassFileName;
	BakedLightingInfo_t m_nodeLightingInfo;
	bool m_bHasBakedGeometryFlag;
};
