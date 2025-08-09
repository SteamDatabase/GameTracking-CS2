// MGetKV3ClassDefaults = {
//	"_class": "CMorphConstraint",
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
//	"m_sTargetMorph": "",
//	"m_nSlaveChannel": 0,
//	"m_flMin": 0.000000,
//	"m_flMax": 1.000000
//}
class CMorphConstraint : public CBaseConstraint
{
	CUtlString m_sTargetMorph;
	int32 m_nSlaveChannel;
	float32 m_flMin;
	float32 m_flMax;
};
