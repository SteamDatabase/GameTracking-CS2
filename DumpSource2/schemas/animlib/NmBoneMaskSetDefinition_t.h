// MGetKV3ClassDefaults = {
//	"m_ID": "",
//	"m_primaryWeightList":
//	{
//		"m_skeletonName": "",
//		"m_boneIDs":
//		[
//		],
//		"m_weights":
//		[
//		]
//	},
//	"m_secondaryWeightLists":
//	[
//	]
//}
class NmBoneMaskSetDefinition_t
{
	CGlobalSymbol m_ID;
	CNmBoneWeightList m_primaryWeightList;
	CUtlLeanVector< CNmBoneWeightList > m_secondaryWeightLists;
};
