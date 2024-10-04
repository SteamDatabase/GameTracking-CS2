class C_OP_RemapModelVolumetoCP : public CParticleFunctionPreEmission
{
	BBoxVolumeType_t m_nBBoxType;
	int32 m_nInControlPointNumber;
	int32 m_nOutControlPointNumber;
	int32 m_nOutControlPointMaxNumber;
	int32 m_nField;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	bool m_bBBoxOnly;
	bool m_bCubeRoot;
};
