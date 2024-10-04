class C_OP_RemapCPtoCP : public CParticleFunctionPreEmission
{
	int32 m_nInputControlPoint;
	int32 m_nOutputControlPoint;
	int32 m_nInputField;
	int32 m_nOutputField;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	bool m_bDerivative;
	float32 m_flInterpRate;
};
