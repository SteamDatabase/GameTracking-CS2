// MGetKV3ClassDefaults = {
//	"_class": "CNmVectorCreateNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_inputVectorValueNodeIdx": -1,
//	"m_inputValueXNodeIdx": -1,
//	"m_inputValueYNodeIdx": -1,
//	"m_inputValueZNodeIdx": -1
//}
class CNmVectorCreateNode::CDefinition : public CNmVectorValueNode::CDefinition
{
	int16 m_inputVectorValueNodeIdx;
	int16 m_inputValueXNodeIdx;
	int16 m_inputValueYNodeIdx;
	int16 m_inputValueZNodeIdx;
};
