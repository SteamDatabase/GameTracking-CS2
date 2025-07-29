// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class ModelMeshBufferData_t
{
	int32 m_nBlockIndex;
	uint32 m_nElementCount;
	uint32 m_nElementSizeInBytes;
	bool m_bMeshoptCompressed;
	bool m_bMeshoptIndexSequence;
	bool m_bCompressedZSTD;
	bool m_bCreateBufferSRV;
	bool m_bCreateBufferUAV;
	bool m_bCreateRawBuffer;
	bool m_bCreatePooledBuffer;
	CUtlVector< RenderInputLayoutField_t > m_inputLayoutFields;
};
