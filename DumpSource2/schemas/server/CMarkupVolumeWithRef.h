class CMarkupVolumeWithRef : public CMarkupVolumeTagged
{
	bool m_bUseRef;
	Vector m_vRefPosEntitySpace;
	VectorWS m_vRefPosWorldSpace;
	float32 m_flRefDot;
};
