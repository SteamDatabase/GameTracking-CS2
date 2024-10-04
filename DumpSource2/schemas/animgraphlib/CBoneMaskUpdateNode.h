class CBoneMaskUpdateNode : public CBinaryUpdateNode
{
	int32 m_nWeightListIndex;
	float32 m_flRootMotionBlend;
	BoneMaskBlendSpace m_blendSpace;
	BinaryNodeChildOption m_footMotionTiming;
	bool m_bUseBlendScale;
	AnimValueSource m_blendValueSource;
	CAnimParamHandle m_hBlendParameter;
}
