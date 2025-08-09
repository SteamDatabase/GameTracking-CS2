// MGetKV3ClassDefaults = {
//	"_class": "CTiltTwistConstraint",
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
//	"m_nTargetAxis": 0,
//	"m_nSlaveAxis": 0
//}
class CTiltTwistConstraint : public CBaseConstraint
{
	int32 m_nTargetAxis;
	int32 m_nSlaveAxis;
};
