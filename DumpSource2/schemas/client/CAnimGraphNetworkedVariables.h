// MNetworkVarNames = "uint32 m_PredNetBoolVariables"
// MNetworkVarNames = "byte m_PredNetByteVariables"
// MNetworkVarNames = "uint16 m_PredNetUInt16Variables"
// MNetworkVarNames = "int32 m_PredNetIntVariables"
// MNetworkVarNames = "uint32 m_PredNetUInt32Variables"
// MNetworkVarNames = "uint64 m_PredNetUInt64Variables"
// MNetworkVarNames = "float m_PredNetFloatVariables"
// MNetworkVarNames = "Vector m_PredNetVectorVariables"
// MNetworkVarNames = "Quaternion m_PredNetQuaternionVariables"
// MNetworkVarNames = "CGlobalSymbol m_PredNetGlobalSymbolVariables"
// MNetworkVarNames = "uint32 m_OwnerOnlyPredNetBoolVariables"
// MNetworkVarNames = "byte m_OwnerOnlyPredNetByteVariables"
// MNetworkVarNames = "uint16 m_OwnerOnlyPredNetUInt16Variables"
// MNetworkVarNames = "int32 m_OwnerOnlyPredNetIntVariables"
// MNetworkVarNames = "uint32 m_OwnerOnlyPredNetUInt32Variables"
// MNetworkVarNames = "uint64 m_OwnerOnlyPredNetUInt64Variables"
// MNetworkVarNames = "float m_OwnerOnlyPredNetFloatVariables"
// MNetworkVarNames = "Vector m_OwnerOnlyPredNetVectorVariables"
// MNetworkVarNames = "Quaternion m_OwnerOnlyPredNetQuaternionVariables"
// MNetworkVarNames = "CGlobalSymbol m_OwnerOnlyPredNetGlobalSymbolVariables"
// MNetworkVarNames = "int m_nBoolVariablesCount"
// MNetworkVarNames = "int m_nOwnerOnlyBoolVariablesCount"
// MNetworkVarNames = "int m_nRandomSeedOffset"
// MNetworkVarNames = "float m_flLastTeleportTime"
class CAnimGraphNetworkedVariables
{
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkChangeCallback = "OnNetBoolVarChanged"
	// MNetworkAlias = "m_PredBoolVariables"
	C_NetworkUtlVectorBase< uint32 > m_PredNetBoolVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkChangeCallback = "OnNetByteVarChanged"
	// MNetworkAlias = "m_PredByteVariables"
	C_NetworkUtlVectorBase< uint8 > m_PredNetByteVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkChangeCallback = "OnNetUInt16VarChanged"
	// MNetworkAlias = "m_PredUInt16Variables"
	C_NetworkUtlVectorBase< uint16 > m_PredNetUInt16Variables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkChangeCallback = "OnNetIntVarChanged"
	// MNetworkAlias = "m_PredIntVariables"
	C_NetworkUtlVectorBase< int32 > m_PredNetIntVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkChangeCallback = "OnNetUInt32VarChanged"
	// MNetworkAlias = "m_PredUInt32Variables"
	C_NetworkUtlVectorBase< uint32 > m_PredNetUInt32Variables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkChangeCallback = "OnNetUInt64VarChanged"
	// MNetworkAlias = "m_PredUInt64Variables"
	C_NetworkUtlVectorBase< uint64 > m_PredNetUInt64Variables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkChangeCallback = "OnNetFloatVarChanged"
	// MNetworkAlias = "m_PredFloatVariables"
	C_NetworkUtlVectorBase< float32 > m_PredNetFloatVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkChangeCallback = "OnNetVectorVarChanged"
	// MNetworkAlias = "m_PredVectorVariables"
	C_NetworkUtlVectorBase< Vector > m_PredNetVectorVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkChangeCallback = "OnNetQuaternionVarChanged"
	// MNetworkAlias = "m_PredQuaternionVariables"
	C_NetworkUtlVectorBase< Quaternion > m_PredNetQuaternionVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkChangeCallback = "OnNetGlobalSymbolVarChanged"
	// MNetworkAlias = "m_PredGlobalSymbolVariables"
	C_NetworkUtlVectorBase< CGlobalSymbol > m_PredNetGlobalSymbolVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkChangeCallback = "OnNetOOBoolVarChanged"
	// MNetworkAlias = "m_OwnerOnlyPredNetBoolVariables"
	C_NetworkUtlVectorBase< uint32 > m_OwnerOnlyPredNetBoolVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkChangeCallback = "OnNetOOByteVarChanged"
	// MNetworkAlias = "m_OwnerOnlyPredNetByteVariables"
	C_NetworkUtlVectorBase< uint8 > m_OwnerOnlyPredNetByteVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkChangeCallback = "OnNetOOUInt16VarChanged"
	// MNetworkAlias = "m_OwnerOnlyPredNetUInt16Variables"
	C_NetworkUtlVectorBase< uint16 > m_OwnerOnlyPredNetUInt16Variables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkChangeCallback = "OnNetOOIntVarChanged"
	// MNetworkAlias = "m_OwnerOnlyPredNetIntVariables"
	C_NetworkUtlVectorBase< int32 > m_OwnerOnlyPredNetIntVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkChangeCallback = "OnNetOOUInt32VarChanged"
	// MNetworkAlias = "m_OwnerOnlyPredNetUInt32Variables"
	C_NetworkUtlVectorBase< uint32 > m_OwnerOnlyPredNetUInt32Variables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkChangeCallback = "OnNetOOUInt64VarChanged"
	// MNetworkAlias = "m_OwnerOnlyPredNetUInt64Variables"
	C_NetworkUtlVectorBase< uint64 > m_OwnerOnlyPredNetUInt64Variables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkChangeCallback = "OnNetOOFloatVarChanged"
	// MNetworkAlias = "m_OwnerOnlyPredNetFloatVariables"
	C_NetworkUtlVectorBase< float32 > m_OwnerOnlyPredNetFloatVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkChangeCallback = "OnNetOOVectorVarChanged"
	// MNetworkAlias = "m_OwnerOnlyPredNetVectorVariables"
	C_NetworkUtlVectorBase< Vector > m_OwnerOnlyPredNetVectorVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkChangeCallback = "OnNetOOQuaternionVarChanged"
	// MNetworkAlias = "m_OwnerOnlyPredNetQuaternionVariables"
	C_NetworkUtlVectorBase< Quaternion > m_OwnerOnlyPredNetQuaternionVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkSendProxyRecipientsFilter (UNKNOWN FOR PARSER)
	// MNetworkChangeCallback = "OnNetOOGlobalSymbolVarChanged"
	// MNetworkAlias = "m_OwnerOnlyPredNetGlobalSymbolVariables"
	C_NetworkUtlVectorBase< CGlobalSymbol > m_OwnerOnlyPredNetGlobalSymbolVariables;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	int32 m_nBoolVariablesCount;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	int32 m_nOwnerOnlyBoolVariablesCount;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	int32 m_nRandomSeedOffset;
	// MNetworkEnable
	// MNetworkUserGroup = "animationgraph"
	// MNetworkChangeCallback = "OnTeleportTimeChanged"
	float32 m_flLastTeleportTime;
};
