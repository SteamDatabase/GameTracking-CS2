// MGetKV3ClassDefaults = {
//	"_class": "CMotionNodeSequence",
//	"m_name": "",
//	"m_id":
//	{
//		"m_id": 4294967295
//	},
//	"m_tags":
//	[
//	],
//	"m_hSequence": -1,
//	"m_flPlaybackSpeed": 1.000000
//}
class CMotionNodeSequence : public CMotionNode
{
	CUtlVector< TagSpan_t > m_tags;
	HSequence m_hSequence;
	float32 m_flPlaybackSpeed;
};
