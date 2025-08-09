// MGetKV3ClassDefaults = {
//	"_class": "CAnimSkeleton",
//	"m_localSpaceTransforms":
//	[
//	],
//	"m_modelSpaceTransforms":
//	[
//	],
//	"m_boneNames":
//	[
//	],
//	"m_children":
//	[
//	],
//	"m_parents":
//	[
//	],
//	"m_feet":
//	[
//	],
//	"m_morphNames":
//	[
//	],
//	"m_lodBoneCounts":
//	[
//	]
//}
class CAnimSkeleton
{
	CUtlVector< CTransform > m_localSpaceTransforms;
	CUtlVector< CTransform > m_modelSpaceTransforms;
	CUtlVector< CUtlString > m_boneNames;
	CUtlVector< CUtlVector< int32 > > m_children;
	CUtlVector< int32 > m_parents;
	CUtlVector< CAnimFoot > m_feet;
	CUtlVector< CUtlString > m_morphNames;
	CUtlVector< int32 > m_lodBoneCounts;
};
