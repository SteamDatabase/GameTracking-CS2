// MGetKV3ClassDefaults = {
//	"m_nElementCount": 0,
//	"m_nElementSizeInBytes": 0,
//	"m_inputLayoutFields":
//	[
//	],
//	"m_pData":
//	[
//	]
//}
class WorldNodeOnDiskBufferData_t
{
	int32 m_nElementCount;
	int32 m_nElementSizeInBytes;
	CUtlVector< RenderInputLayoutField_t > m_inputLayoutFields;
	CUtlVector< uint8 > m_pData;
};
