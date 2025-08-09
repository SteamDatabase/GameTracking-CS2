// MGetKV3ClassDefaults = {
//	"_class": "CAnimReplayFrame",
//	"m_inputDataBlocks":
//	[
//	],
//	"m_instanceData": "[BINARY BLOB]",
//	"m_startingLocalToWorldTransform":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_localToWorldTransform":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000,
//		0.000000,
//		0.000000,
//		0.000000,
//		1.000000
//	],
//	"m_timeStamp": 0.000000
//}
class CAnimReplayFrame
{
	CUtlVector< CUtlBinaryBlock > m_inputDataBlocks;
	CUtlBinaryBlock m_instanceData;
	CTransform m_startingLocalToWorldTransform;
	CTransform m_localToWorldTransform;
	float32 m_timeStamp;
};
