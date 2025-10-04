// MGetKV3ClassDefaults = {
//	"m_rootNode":
//	{
//		"m_children":
//		[
//		],
//		"m_quantizer":
//		{
//			"m_centroidVectors":
//			[
//			],
//			"m_nCentroids": 0,
//			"m_nDimensions": 0
//		},
//		"m_sampleCodes":
//		[
//		],
//		"m_sampleIndices":
//		[
//		],
//		"m_selectableSamples":
//		[
//		]
//	},
//	"m_residualQuantizer":
//	{
//		"m_subQuantizers":
//		[
//		],
//		"m_nDimensions": 0
//	},
//	"m_codeIndices":
//	[
//	]
//}
class CMotionSearchDB
{
	CMotionSearchNode m_rootNode;
	CProductQuantizer m_residualQuantizer;
	CUtlVector< MotionDBIndex > m_codeIndices;
};
