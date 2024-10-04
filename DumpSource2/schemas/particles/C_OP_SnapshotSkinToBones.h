class C_OP_SnapshotSkinToBones : public CParticleFunctionOperator
{
	bool m_bTransformNormals;
	bool m_bTransformRadii;
	int32 m_nControlPointNumber;
	float32 m_flLifeTimeFadeStart;
	float32 m_flLifeTimeFadeEnd;
	float32 m_flJumpThreshold;
	float32 m_flPrevPosScale;
};
