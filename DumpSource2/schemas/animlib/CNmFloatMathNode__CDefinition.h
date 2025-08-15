// MGetKV3ClassDefaults = {
//	"_class": "CNmFloatMathNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nInputValueNodeIdxA": -1,
//	"m_nInputValueNodeIdxB": -1,
//	"m_bReturnAbsoluteResult": false,
//	"m_bReturnNegatedResult": false,
//	"m_operator": "Add",
//	"m_flValueB": 0.000000
//}
class CNmFloatMathNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdxA;
	int16 m_nInputValueNodeIdxB;
	bool m_bReturnAbsoluteResult;
	bool m_bReturnNegatedResult;
	CNmFloatMathNode::Operator_t m_operator;
	float32 m_flValueB;
};
