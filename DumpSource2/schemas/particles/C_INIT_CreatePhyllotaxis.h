class C_INIT_CreatePhyllotaxis : public CParticleFunctionInitializer
{
	int32 m_nControlPointNumber;
	int32 m_nScaleCP;
	int32 m_nComponent;
	float32 m_fRadCentCore;
	float32 m_fRadPerPoint;
	float32 m_fRadPerPointTo;
	float32 m_fpointAngle;
	float32 m_fsizeOverall;
	float32 m_fRadBias;
	float32 m_fMinRad;
	float32 m_fDistBias;
	bool m_bUseLocalCoords;
	bool m_bUseWithContEmit;
	bool m_bUseOrigRadius;
};
