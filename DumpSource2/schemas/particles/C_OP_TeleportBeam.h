class C_OP_TeleportBeam : public CParticleFunctionOperator
{
	int32 m_nCPPosition;
	int32 m_nCPVelocity;
	int32 m_nCPMisc;
	int32 m_nCPColor;
	int32 m_nCPInvalidColor;
	int32 m_nCPExtraArcData;
	Vector m_vGravity;
	float32 m_flArcMaxDuration;
	float32 m_flSegmentBreak;
	float32 m_flArcSpeed;
	float32 m_flAlpha;
};
