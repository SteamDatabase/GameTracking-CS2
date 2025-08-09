// MGetKV3ClassDefaults = {
//	"_class": "CAnimUpdateSharedData",
//	"m_nodes":
//	[
//	],
//	"m_nodeIndexMap":
//	[
//	],
//	"m_components":
//	[
//	],
//	"m_pParamListUpdater": null,
//	"m_pTagManagerUpdater": null,
//	"m_scriptManager": null,
//	"m_settings":
//	{
//		"_class": "CAnimGraphSettingsManager",
//		"m_settingsGroups":
//		[
//			{
//				"_class": "CAnimGraphNetworkSettings",
//				"m_bNetworkingEnabled": true
//			}
//		]
//	},
//	"m_pStaticPoseCache": null,
//	"m_pSkeleton": null,
//	"m_rootNodePath":
//	{
//		"m_path":
//		[
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			},
//			{
//				"m_id": 4294967295
//			}
//		],
//		"m_nCount": 0
//	}
//}
class CAnimUpdateSharedData
{
	CUtlVector< CSmartPtr< CAnimUpdateNodeBase > > m_nodes;
	CUtlHashtable< CAnimNodePath, int32 > m_nodeIndexMap;
	CUtlVector< CSmartPtr< CAnimComponentUpdater > > m_components;
	CSmartPtr< CAnimParameterManagerUpdater > m_pParamListUpdater;
	CSmartPtr< CAnimTagManagerUpdater > m_pTagManagerUpdater;
	CSmartPtr< CAnimScriptManager > m_scriptManager;
	CAnimGraphSettingsManager m_settings;
	CSmartPtr< CStaticPoseCacheBuilder > m_pStaticPoseCache;
	CSmartPtr< CAnimSkeleton > m_pSkeleton;
	CAnimNodePath m_rootNodePath;
};
