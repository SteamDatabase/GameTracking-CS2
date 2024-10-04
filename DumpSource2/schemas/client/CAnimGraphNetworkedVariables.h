class CAnimGraphNetworkedVariables
{
	C_NetworkUtlVectorBase< uint32 > m_PredNetBoolVariables;
	C_NetworkUtlVectorBase< uint8 > m_PredNetByteVariables;
	C_NetworkUtlVectorBase< uint16 > m_PredNetUInt16Variables;
	C_NetworkUtlVectorBase< int32 > m_PredNetIntVariables;
	C_NetworkUtlVectorBase< uint32 > m_PredNetUInt32Variables;
	C_NetworkUtlVectorBase< uint64 > m_PredNetUInt64Variables;
	C_NetworkUtlVectorBase< float32 > m_PredNetFloatVariables;
	C_NetworkUtlVectorBase< Vector > m_PredNetVectorVariables;
	C_NetworkUtlVectorBase< Quaternion > m_PredNetQuaternionVariables;
	C_NetworkUtlVectorBase< CGlobalSymbol > m_PredNetGlobalSymbolVariables;
	C_NetworkUtlVectorBase< uint32 > m_OwnerOnlyPredNetBoolVariables;
	C_NetworkUtlVectorBase< uint8 > m_OwnerOnlyPredNetByteVariables;
	C_NetworkUtlVectorBase< uint16 > m_OwnerOnlyPredNetUInt16Variables;
	C_NetworkUtlVectorBase< int32 > m_OwnerOnlyPredNetIntVariables;
	C_NetworkUtlVectorBase< uint32 > m_OwnerOnlyPredNetUInt32Variables;
	C_NetworkUtlVectorBase< uint64 > m_OwnerOnlyPredNetUInt64Variables;
	C_NetworkUtlVectorBase< float32 > m_OwnerOnlyPredNetFloatVariables;
	C_NetworkUtlVectorBase< Vector > m_OwnerOnlyPredNetVectorVariables;
	C_NetworkUtlVectorBase< Quaternion > m_OwnerOnlyPredNetQuaternionVariables;
	C_NetworkUtlVectorBase< CGlobalSymbol > m_OwnerOnlyPredNetGlobalSymbolVariables;
	int32 m_nBoolVariablesCount;
	int32 m_nOwnerOnlyBoolVariablesCount;
	int32 m_nRandomSeedOffset;
	float32 m_flLastTeleportTime;
}
