// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_parent": 0,
//	"m_pos":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_quat":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_scale": 1.000000,
//	"m_qAlignment":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_flags": 0
//}
class CAnimBone
{
	CBufferString m_name;
	int32 m_parent;
	Vector m_pos;
	QuaternionStorage m_quat;
	float32 m_scale;
	QuaternionStorage m_qAlignment;
	int32 m_flags;
};
