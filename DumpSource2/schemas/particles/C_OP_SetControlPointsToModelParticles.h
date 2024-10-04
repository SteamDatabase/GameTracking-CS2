class C_OP_SetControlPointsToModelParticles : public CParticleFunctionOperator
{
	char[128] m_HitboxSetName;
	char[128] m_AttachmentName;
	int32 m_nFirstControlPoint;
	int32 m_nNumControlPoints;
	int32 m_nFirstSourcePoint;
	bool m_bSkin;
	bool m_bAttachment;
};
