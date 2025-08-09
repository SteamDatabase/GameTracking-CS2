// MGetKV3ClassDefaults = {
//	"_class": "CTwistConstraint",
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
//	"m_bInverse": false,
//	"m_qParentBindRotation":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_qChildBindRotation":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	]
//}
class CTwistConstraint : public CBaseConstraint
{
	bool m_bInverse;
	Quaternion m_qParentBindRotation;
	Quaternion m_qChildBindRotation;
};
