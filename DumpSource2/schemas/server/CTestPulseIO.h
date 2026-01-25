class CTestPulseIO : public CLogicalEntity
{
	CEntityIOOutput m_OnVariantVoid;
	CEntityOutputTemplate< bool, bool > m_OnVariantBool;
	CEntityOutputTemplate< int32, int32 > m_OnVariantInt;
	CEntityOutputTemplate< float32, float32 > m_OnVariantFloat;
	CEntityOutputTemplate< CUtlSymbolLarge, CUtlSymbolLarge > m_OnVariantString;
	CEntityOutputTemplate< Color, Color > m_OnVariantColor;
	CEntityOutputTemplate< Vector, Vector > m_OnVariantVector;
	bool m_bAllowEmptyInputs;
};
