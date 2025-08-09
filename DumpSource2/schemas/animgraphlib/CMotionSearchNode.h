// MGetKV3ClassDefaults = {
//	"m_children":
//	[
//	],
//	"m_quantizer":
//	{
//		"m_centroidVectors":
//		[
//		],
//		"m_nCentroids": 0,
//		"m_nDimensions": 0
//	},
//	"m_sampleCodes":
//	[
//	],
//	"m_sampleIndices":
//	[
//	],
//	"m_selectableSamples":
//	[
//	]
//}
class CMotionSearchNode
{
	CUtlVector< CMotionSearchNode* > m_children;
	CVectorQuantizer m_quantizer;
	CUtlVector< CUtlVector< SampleCode > > m_sampleCodes;
	CUtlVector< CUtlVector< int32 > > m_sampleIndices;
	CUtlVector< int32 > m_selectableSamples;
};
