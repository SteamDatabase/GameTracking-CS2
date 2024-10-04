class C_OP_VelocityMatchingForce : public CParticleFunctionOperator
{
	float32 m_flDirScale;
	float32 m_flSpdScale;
	float32 m_flNeighborDistance;
	float32 m_flFacingStrength;
	bool m_bUseAABB;
	int32 m_nCPBroadcast;
};
