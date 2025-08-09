// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_boneArray":
//	[
//	],
//	"m_userArray":
//	[
//	],
//	"m_morphArray":
//	[
//	],
//	"m_nChannelElements": 0,
//	"m_dataChannelArray":
//	[
//	]
//}
class CAnimKeyData
{
	CBufferString m_name;
	CUtlVector< CAnimBone > m_boneArray;
	CUtlVector< CAnimUser > m_userArray;
	CUtlVector< CBufferString > m_morphArray;
	int32 m_nChannelElements;
	CUtlVector< CAnimDataChannelDesc > m_dataChannelArray;
};
