// MGetKV3ClassDefaults = {
//	"_class": "CNmReferencedGraphNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nReferencedGraphIdx": -1,
//	"m_nFallbackNodeIdx": -1
//}
class CNmReferencedGraphNode::CDefinition : public CNmPoseNode::CDefinition
{
	int16 m_nReferencedGraphIdx;
	int16 m_nFallbackNodeIdx;
};
