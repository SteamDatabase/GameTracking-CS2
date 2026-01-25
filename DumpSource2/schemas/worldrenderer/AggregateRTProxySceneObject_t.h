// MGetKV3ClassDefaults = {
//	"m_nLayer": 0,
//	"m_BLASes":
//	[
//	],
//	"m_Instances":
//	[
//	],
//	"m_VBData": "[BINARY BLOB]",
//	"m_IBData": "[BINARY BLOB]",
//	"m_InstanceAlbedoData": "[BINARY BLOB]"
//}
class AggregateRTProxySceneObject_t
{
	int16 m_nLayer;
	CUtlVector< RTProxyBLAS_t > m_BLASes;
	CUtlVector< RTProxyInstanceInfo_t > m_Instances;
	CUtlBinaryBlock m_VBData;
	CUtlBinaryBlock m_IBData;
	CUtlBinaryBlock m_InstanceAlbedoData;
};
