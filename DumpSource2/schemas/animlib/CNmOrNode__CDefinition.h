// MGetKV3ClassDefaults = {
//	"_class": "CNmOrNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_conditionNodeIndices":
//	[
//	]
//}
class CNmOrNode::CDefinition : public CNmBoolValueNode::CDefinition
{
	CUtlLeanVectorFixedGrowable< int16, 4 > m_conditionNodeIndices;
};
