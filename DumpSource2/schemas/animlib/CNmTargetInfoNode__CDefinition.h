// MGetKV3ClassDefaults = {
//	"_class": "CNmTargetInfoNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdx": -1,
//	"m_infoType": "Distance",
//	"m_bIsWorldSpaceTarget": true
//}
class CNmTargetInfoNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	CNmTargetInfoNode::Info_t m_infoType;
	bool m_bIsWorldSpaceTarget;
};
