// MGetKV3ClassDefaults = {
//	"m_tags":
//	[
//	],
//	"m_pChild":
//	{
//		"m_nodeIndex": -1
//	},
//	"m_hSequence": -1,
//	"m_vPos":
//	[
//		0.000000,
//		0.000000
//	],
//	"m_flDuration": 0.000000,
//	"m_bUseCustomDuration": false
//}
class BlendItem_t
{
	CUtlVector< TagSpan_t > m_tags;
	CAnimUpdateNodeRef m_pChild;
	HSequence m_hSequence;
	Vector2D m_vPos;
	float32 m_flDuration;
	bool m_bUseCustomDuration;
};
