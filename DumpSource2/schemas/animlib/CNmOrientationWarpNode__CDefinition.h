class CNmOrientationWarpNode::CDefinition : public CNmPoseNode::CDefinition
{
	int16 m_nClipReferenceNodeIdx;
	int16 m_nTargetValueNodeIdx;
	bool m_bIsOffsetNode;
	bool m_bIsOffsetRelativeToCharacter;
	CNmRootMotionData::SamplingMode_t m_samplingMode;
}
