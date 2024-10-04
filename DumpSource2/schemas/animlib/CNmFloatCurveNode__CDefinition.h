class CNmFloatCurveNode::CDefinition : public CNmFloatValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	CPiecewiseCurve m_curve;
};
