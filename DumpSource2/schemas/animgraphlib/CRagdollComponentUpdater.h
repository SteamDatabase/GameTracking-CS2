// MGetKV3ClassDefaults = {
//	"_class": "CRagdollComponentUpdater",
//	"m_name": "",
//	"m_id":
//	{
//		"m_id": 4294967295
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_bStartEnabled": false,
//	"m_ragdollNodePaths":
//	[
//	],
//	"m_followAttachmentNodePaths":
//	[
//	],
//	"m_boneIndices":
//	[
//	],
//	"m_boneNames":
//	[
//	],
//	"m_weightLists":
//	[
//	],
//	"m_boneToWeightIndices":
//	[
//	],
//	"m_flSpringFrequencyMin": 0.000000,
//	"m_flSpringFrequencyMax": 15.000000,
//	"m_flMaxStretch": 56.000000,
//	"m_bSolidCollisionAtZeroWeight": false
//}
class CRagdollComponentUpdater : public CAnimComponentUpdater
{
	CUtlVector< CAnimNodePath > m_ragdollNodePaths;
	CUtlVector< CAnimNodePath > m_followAttachmentNodePaths;
	CUtlVector< int32 > m_boneIndices;
	CUtlVector< CUtlString > m_boneNames;
	CUtlVector< WeightList > m_weightLists;
	CUtlVector< int32 > m_boneToWeightIndices;
	float32 m_flSpringFrequencyMin;
	float32 m_flSpringFrequencyMax;
	float32 m_flMaxStretch;
	bool m_bSolidCollisionAtZeroWeight;
};
