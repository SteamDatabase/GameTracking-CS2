class C_OP_SetControlPointPositionToTimeOfDayValue : public CParticleFunctionPreEmission
{
	int32 m_nControlPointNumber;
	char[128] m_pszTimeOfDayParameter;
	Vector m_vecDefaultValue;
};
