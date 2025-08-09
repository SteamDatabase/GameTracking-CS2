// MGetKV3ClassDefaults = {
//	"_class": "CBoneConstraintPoseSpaceMorph",
//	"m_sBoneName": "",
//	"m_sAttachmentName": "",
//	"m_outputMorph":
//	[
//	],
//	"m_inputList":
//	[
//	],
//	"m_bClamp": false,
//	"m_eRbfType": 0,
//	"m_flFalloff": 1.000000
//}
class CBoneConstraintPoseSpaceMorph : public CBoneConstraintBase
{
	CUtlString m_sBoneName;
	CUtlString m_sAttachmentName;
	CUtlVector< CUtlString > m_outputMorph;
	CUtlVector< CBoneConstraintPoseSpaceMorph::Input_t > m_inputList;
	bool m_bClamp;
};
