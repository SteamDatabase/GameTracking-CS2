class CAnimGraphNetworkedVariables
{
	CNetworkUtlVectorBase< uint32 > m_PredNetBoolVariables;
	CNetworkUtlVectorBase< uint8 > m_PredNetByteVariables;
	CNetworkUtlVectorBase< uint16 > m_PredNetUInt16Variables;
	CNetworkUtlVectorBase< int32 > m_PredNetIntVariables;
	CNetworkUtlVectorBase< uint32 > m_PredNetUInt32Variables;
	CNetworkUtlVectorBase< uint64 > m_PredNetUInt64Variables;
	CNetworkUtlVectorBase< float32 > m_PredNetFloatVariables;
	CNetworkUtlVectorBase< Vector > m_PredNetVectorVariables;
	CNetworkUtlVectorBase< Quaternion > m_PredNetQuaternionVariables;
	CNetworkUtlVectorBase< CGlobalSymbol > m_PredNetGlobalSymbolVariables;
	CNetworkUtlVectorBase< uint32 > m_OwnerOnlyPredNetBoolVariables;
	CNetworkUtlVectorBase< uint8 > m_OwnerOnlyPredNetByteVariables;
	CNetworkUtlVectorBase< uint16 > m_OwnerOnlyPredNetUInt16Variables;
	CNetworkUtlVectorBase< int32 > m_OwnerOnlyPredNetIntVariables;
	CNetworkUtlVectorBase< uint32 > m_OwnerOnlyPredNetUInt32Variables;
	CNetworkUtlVectorBase< uint64 > m_OwnerOnlyPredNetUInt64Variables;
	CNetworkUtlVectorBase< float32 > m_OwnerOnlyPredNetFloatVariables;
	CNetworkUtlVectorBase< Vector > m_OwnerOnlyPredNetVectorVariables;
	CNetworkUtlVectorBase< Quaternion > m_OwnerOnlyPredNetQuaternionVariables;
	CNetworkUtlVectorBase< CGlobalSymbol > m_OwnerOnlyPredNetGlobalSymbolVariables;
	int32 m_nBoolVariablesCount;
	int32 m_nOwnerOnlyBoolVariablesCount;
	int32 m_nRandomSeedOffset;
	float32 m_flLastTeleportTime;
};
