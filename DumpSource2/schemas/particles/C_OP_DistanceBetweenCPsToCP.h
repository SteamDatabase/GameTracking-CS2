class C_OP_DistanceBetweenCPsToCP : public CParticleFunctionPreEmission
{
	int32 m_nStartCP;
	int32 m_nEndCP;
	int32 m_nOutputCP;
	int32 m_nOutputCPField;
	bool m_bSetOnce;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	float32 m_flMaxTraceLength;
	float32 m_flLOSScale;
	bool m_bLOS;
	char[128] m_CollisionGroupName;
	ParticleTraceSet_t m_nTraceSet;
	ParticleParentSetMode_t m_nSetParent;
};
