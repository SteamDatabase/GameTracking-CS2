// MGetKV3ClassDefaults = {
//	"_class": "CNmTargetOffsetNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_bIsBoneSpaceOffset": true,
//	"m_rotationOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_translationOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	]
//}
class CNmTargetOffsetNode::CDefinition : public CNmTargetValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	bool m_bIsBoneSpaceOffset;
	Quaternion m_rotationOffset;
	Vector m_translationOffset;
};
