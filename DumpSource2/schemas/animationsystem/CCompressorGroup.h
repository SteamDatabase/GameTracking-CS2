class CCompressorGroup
{
	int32 m_nTotalElementCount;
	CUtlVector< char* > m_szChannelClass;
	CUtlVector< char* > m_szVariableName;
	CUtlVector< fieldtype_t > m_nType;
	CUtlVector< int32 > m_nFlags;
	CUtlVector< CUtlString > m_szGrouping;
	CUtlVector< int32 > m_nCompressorIndex;
	CUtlVector< CUtlVector< char* > > m_szElementNames;
	CUtlVector< CUtlVector< int32 > > m_nElementUniqueID;
	CUtlVector< uint32 > m_nElementMask;
	CUtlVector< CCompressor< Vector >* > m_vectorCompressor;
	CUtlVector< CCompressor< QuaternionStorage >* > m_quaternionCompressor;
	CUtlVector< CCompressor< int32 >* > m_intCompressor;
	CUtlVector< CCompressor< bool >* > m_boolCompressor;
	CUtlVector< CCompressor< Color >* > m_colorCompressor;
	CUtlVector< CCompressor< Vector2D >* > m_vector2DCompressor;
	CUtlVector< CCompressor< Vector4D >* > m_vector4DCompressor;
};
