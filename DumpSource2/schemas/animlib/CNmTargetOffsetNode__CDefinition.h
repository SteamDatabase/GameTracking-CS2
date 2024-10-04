class CNmTargetOffsetNode::CDefinition : public CNmTargetValueNode::CDefinition
{
	int16 m_nInputValueNodeIdx;
	bool m_bIsBoneSpaceOffset;
	Quaternion m_rotationOffset;
	Vector m_translationOffset;
}
