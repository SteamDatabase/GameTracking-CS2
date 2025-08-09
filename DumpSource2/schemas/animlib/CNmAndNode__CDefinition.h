// MGetKV3ClassDefaults = {
//	"_class": "CNmAndNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_conditionNodeIndices":
//	[
//	]
//}
class CNmAndNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	CUtlLeanVectorFixedGrowable< int16, 4 > m_conditionNodeIndices;
};
