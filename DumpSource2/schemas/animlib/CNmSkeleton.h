// MGetKV3ClassDefaults = {
//	"m_ID": "",
//	"m_boneIDs":
//	[
//	],
//	"m_parentIndices":
//	[
//	],
//	"m_parentSpaceReferencePose":
//	[
//	],
//	"m_modelSpaceReferencePose":
//	[
//	],
//	"m_numBonesToSampleAtLowLOD": 0,
//	"m_maskDefinitions":
//	[
//	],
//	"m_secondarySkeletons":
//	[
//	],
//	"m_bIsPropSkeleton": false
//}
class CNmSkeleton
{
	CGlobalSymbol m_ID;
	CUtlLeanVector< CGlobalSymbol > m_boneIDs;
	CUtlVector< int32 > m_parentIndices;
	CUtlVector< CTransform > m_parentSpaceReferencePose;
	CUtlVector< CTransform > m_modelSpaceReferencePose;
	int32 m_numBonesToSampleAtLowLOD;
	CUtlLeanVector< NmBoneMaskSetDefinition_t > m_maskDefinitions;
	CUtlLeanVector< CNmSkeleton::SecondarySkeleton_t > m_secondarySkeletons;
	bool m_bIsPropSkeleton;
};
