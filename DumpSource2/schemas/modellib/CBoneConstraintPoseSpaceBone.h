// MGetKV3ClassDefaults = {
//	"_class": "CBoneConstraintPoseSpaceBone",
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
//	"m_inputList":
//	[
//	],
//	"m_eRbfType": 0,
//	"m_flFalloff": 1.000000
//}
class CBoneConstraintPoseSpaceBone : public CBaseConstraint
{
	CUtlVector< CBoneConstraintPoseSpaceBone::Input_t > m_inputList;
};
