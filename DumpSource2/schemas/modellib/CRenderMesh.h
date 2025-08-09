// MGetKV3ClassDefaults = {
//	"_class": "CRenderMesh",
//	"m_sceneObjects":
//	[
//	],
//	"m_constraints":
//	[
//	],
//	"m_skeleton":
//	{
//		"m_bones":
//		[
//		],
//		"m_boneParents":
//		[
//		],
//		"m_nBoneWeightCount": 4
//	},
//	"m_bUseUV2ForCharting": false,
//	"m_bEmbeddedMapMesh": false,
//	"m_meshDeformParams":
//	{
//		"m_flTensionCompressScale": 0.000000,
//		"m_flTensionStretchScale": 0.000000,
//		"m_bRecomputeSmoothNormalsAfterAnimation": false,
//		"m_bComputeDynamicMeshTensionAfterAnimation": false,
//		"m_bSmoothNormalsAcrossUvSeams": false
//	},
//	"m_pGroomData": null,
//	"m_attachments":
//	[
//	],
//	"m_hitboxsets":
//	[
//	],
//	"m_morphSet": ""
//}
class CRenderMesh
{
	CUtlLeanVectorFixedGrowable< CSceneObjectData, 1 > m_sceneObjects;
	CUtlLeanVector< CBaseConstraint* > m_constraints;
	CRenderSkeleton m_skeleton;
	bool m_bUseUV2ForCharting;
	bool m_bEmbeddedMapMesh;
	DynamicMeshDeformParams_t m_meshDeformParams;
	CRenderGroom* m_pGroomData;
};
