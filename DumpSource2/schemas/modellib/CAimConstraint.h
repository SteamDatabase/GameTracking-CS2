// MGetKV3ClassDefaults = {
//	"_class": "CAimConstraint",
//	"m_name": "",
//	"m_vUpVector":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_slaves":
//	[
//	],
//	"m_targets":
//	[
//	],
//	"m_qAimOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_nUpType": 0
//}
class CAimConstraint : public CBaseConstraint
{
	Quaternion m_qAimOffset;
	uint32 m_nUpType;
};
