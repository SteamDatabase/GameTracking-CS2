class TwoBoneIKSettings_t
{
	IkEndEffectorType m_endEffectorType;
	CAnimAttachment m_endEffectorAttachment;
	IkTargetType m_targetType;
	CAnimAttachment m_targetAttachment;
	int32 m_targetBoneIndex;
	CAnimParamHandle m_hPositionParam;
	CAnimParamHandle m_hRotationParam;
	bool m_bAlwaysUseFallbackHinge;
	VectorAligned m_vLsFallbackHingeAxis;
	int32 m_nFixedBoneIndex;
	int32 m_nMiddleBoneIndex;
	int32 m_nEndBoneIndex;
	bool m_bMatchTargetOrientation;
	bool m_bConstrainTwist;
	float32 m_flMaxTwist;
};
