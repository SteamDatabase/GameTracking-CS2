// MGetKV3ClassDefaults = {
//	"m_nBlockIndex": -1,
//	"m_nElementCount": 0,
//	"m_nElementSizeInBytes": 0,
//	"m_bMeshoptCompressed": false,
//	"m_bMeshoptIndexSequence": false,
//	"m_bCompressedZSTD": false,
//	"m_bCreateBufferSRV": false,
//	"m_bCreateBufferUAV": false,
//	"m_bCreateRawBuffer": false,
//	"m_bCreatePooledBuffer": false,
//	"m_inputLayoutFields":
//	[
//	]
//}
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
