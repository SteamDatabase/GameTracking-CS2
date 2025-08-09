// MGetKV3ClassDefaults = {
//	"_class": "CDirectionalBlendUpdateNode",
//	"m_nodePath":
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
//	},
//	"m_networkMode": "ServerAuthoritative",
//	"m_name": "",
//	"m_hSequences":
//	[
//		-1,
//		-1,
//		-1,
//		-1,
//		-1,
//		-1,
//		-1,
//		-1
//	],
//	"m_damping":
//	{
//		"_class": "CAnimInputDamping",
//		"m_speedFunction": "NoDamping",
//		"m_fSpeedScale": 1.000000,
//		"m_fFallingSpeedScale": 1.000000
//	},
//	"m_blendValueSource": "MoveHeading",
//	"m_paramIndex":
//	{
//		"m_type": "ANIMPARAM_UNKNOWN",
//		"m_index": 255
//	},
//	"m_playbackSpeed": 0.000000,
//	"m_duration": 0.000000,
//	"m_bLoop": false,
//	"m_bLockBlendOnReset": false
//}
class CDirectionalBlendUpdateNode : public CLeafUpdateNode
{
	HSequence[8] m_hSequences;
	CAnimInputDamping m_damping;
	AnimValueSource m_blendValueSource;
	CAnimParamHandle m_paramIndex;
	float32 m_playbackSpeed;
	float32 m_duration;
	bool m_bLoop;
	bool m_bLockBlendOnReset;
};
