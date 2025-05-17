// MNetworkVarNames = "attrib_definition_index_t m_iAttributeDefinitionIndex"
// MNetworkVarNames = "float m_flValue"
// MNetworkVarNames = "float m_flInitialValue"
// MNetworkVarNames = "int m_nRefundableCurrency"
// MNetworkVarNames = "bool m_bSetBonus"
class CEconItemAttribute
{
	// MNetworkEnable
	uint16 m_iAttributeDefinitionIndex;
	// MNetworkEnable
	// MNetworkAlias = "m_iRawValue32"
	float32 m_flValue;
	// MNetworkEnable
	float32 m_flInitialValue;
	// MNetworkEnable
	int32 m_nRefundableCurrency;
	// MNetworkEnable
	bool m_bSetBonus;
};
