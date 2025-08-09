// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_modelInfo":
//	{
//		"m_nFlags": 0,
//		"m_vHullMin":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_vHullMax":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_vViewMin":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_vViewMax":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_flMass": 0.000000,
//		"m_vEyePosition":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"m_flMaxEyeDeflection": 0.000000,
//		"m_sSurfaceProperty": "",
//		"m_keyValueText": ""
//	},
//	"m_ExtParts":
//	[
//	],
//	"m_refMeshes":
//	[
//	],
//	"m_refMeshGroupMasks":
//	[
//	],
//	"m_refPhysGroupMasks":
//	[
//	],
//	"m_refLODGroupMasks":
//	[
//	],
//	"m_lodGroupSwitchDistances":
//	[
//	],
//	"m_refPhysicsData":
//	[
//	],
//	"m_refPhysicsHitboxData":
//	[
//	],
//	"m_refAnimGroups":
//	[
//	],
//	"m_refSequenceGroups":
//	[
//	],
//	"m_meshGroups":
//	[
//	],
//	"m_materialGroups":
//	[
//	],
//	"m_nDefaultMeshGroupMask": 0,
//	"m_modelSkeleton":
//	{
//		"m_boneName":
//		[
//		],
//		"m_nParent":
//		[
//		],
//		"m_boneSphere":
//		[
//		],
//		"m_nFlag":
//		[
//		],
//		"m_bonePosParent":
//		[
//		],
//		"m_boneRotParent":
//		[
//		],
//		"m_boneScaleParent":
//		[
//		]
//	},
//	"m_remappingTable":
//	[
//	],
//	"m_remappingTableStarts":
//	[
//	],
//	"m_boneFlexDrivers":
//	[
//	],
//	"m_pModelConfigList": null,
//	"m_BodyGroupsHiddenInTools":
//	[
//	],
//	"m_refAnimIncludeModels":
//	[
//	],
//	"m_AnimatedMaterialAttributes":
//	[
//	]
//}
class PermModelData_t
{
	CUtlString m_name;
	PermModelInfo_t m_modelInfo;
	CUtlVector< PermModelExtPart_t > m_ExtParts;
	CUtlVector< CStrongHandle< InfoForResourceTypeCRenderMesh > > m_refMeshes;
	CUtlVector< uint64 > m_refMeshGroupMasks;
	CUtlVector< uint64 > m_refPhysGroupMasks;
	CUtlVector< uint8 > m_refLODGroupMasks;
	CUtlVector< float32 > m_lodGroupSwitchDistances;
	CUtlVector< CStrongHandle< InfoForResourceTypeCPhysAggregateData > > m_refPhysicsData;
	CUtlVector< CStrongHandle< InfoForResourceTypeCPhysAggregateData > > m_refPhysicsHitboxData;
	CUtlVector< CStrongHandle< InfoForResourceTypeCAnimationGroup > > m_refAnimGroups;
	CUtlVector< CStrongHandle< InfoForResourceTypeCSequenceGroupData > > m_refSequenceGroups;
	CUtlVector< CUtlString > m_meshGroups;
	CUtlVector< MaterialGroup_t > m_materialGroups;
	uint64 m_nDefaultMeshGroupMask;
	ModelSkeletonData_t m_modelSkeleton;
	CUtlVector< int16 > m_remappingTable;
	CUtlVector< uint16 > m_remappingTableStarts;
	CUtlVector< ModelBoneFlexDriver_t > m_boneFlexDrivers;
	CModelConfigList* m_pModelConfigList;
	CUtlVector< CUtlString > m_BodyGroupsHiddenInTools;
	CUtlVector< CStrongHandle< InfoForResourceTypeCModel > > m_refAnimIncludeModels;
	CUtlVector< PermModelDataAnimatedMaterialAttribute_t > m_AnimatedMaterialAttributes;
};
