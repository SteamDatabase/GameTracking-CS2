// MGetKV3ClassDefaults = {
//	"_class": "CBoneConstraintDotToMorph",
//	"m_sBoneName": "",
//	"m_sTargetBoneName": "",
//	"m_sMorphChannelName": "",
//	"m_flRemap":
//	[
//		0.000000,
//		180.000000,
//		0.000000,
//		1.000000
//	]
//}
class CBoneConstraintDotToMorph : public CBoneConstraintBase
{
	CUtlString m_sBoneName;
	CUtlString m_sTargetBoneName;
	CUtlString m_sMorphChannelName;
	float32[4] m_flRemap;
};
