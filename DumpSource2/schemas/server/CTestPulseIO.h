class CTestPulseIO : public CLogicalEntity
{
	CEntityIOOutput m_OnVariantVoid;
	CEntityIOOutput m_OnVariantBool;
	CEntityIOOutput m_OnVariantInt;
	CEntityIOOutput m_OnVariantFloat;
	CEntityIOOutput m_OnVariantString;
	CEntityIOOutput m_OnVariantColor;
	CEntityIOOutput m_OnVariantVector;
	bool m_bAllowEmptyInputs;
};
