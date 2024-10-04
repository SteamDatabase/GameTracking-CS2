class C_OP_DriveCPFromGlobalSoundFloat : public CParticleFunctionPreEmission
{
	int32 m_nOutputControlPoint;
	int32 m_nOutputField;
	float32 m_flInputMin;
	float32 m_flInputMax;
	float32 m_flOutputMin;
	float32 m_flOutputMax;
	CUtlString m_StackName;
	CUtlString m_OperatorName;
	CUtlString m_FieldName;
};
