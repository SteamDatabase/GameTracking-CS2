// MGetKV3ClassDefaults = {
//	"m_bones":
//	[
//	],
//	"m_boneParents":
//	[
//	],
//	"m_nBoneWeightCount": 4
//}
class CRenderSkeleton
{
	CUtlVector< RenderSkeletonBone_t > m_bones;
	CUtlVector< int32 > m_boneParents;
	int32 m_nBoneWeightCount;
};
