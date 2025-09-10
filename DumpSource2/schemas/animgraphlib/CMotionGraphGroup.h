// MGetKV3ClassDefaults = {
//	"m_searchDB":
//	{
//		"m_rootNode":
//		{
//			"m_children":
//			[
//			],
//			"m_quantizer":
//			{
//				"m_centroidVectors":
//				[
//				],
//				"m_nCentroids": <HIDDEN FOR DIFF>,
//				"m_nDimensions": 32767
//			},
//			"m_sampleCodes":
//			[
//			],
//			"m_sampleIndices":
//			[
//			],
//			"m_selectableSamples":
//			[
//			]
//		},
//		"m_residualQuantizer":
//		{
//			"m_subQuantizers":
//			[
//			],
//			"m_nDimensions": 0
//		},
//		"m_codeIndices":
//		[
//		]
//	},
//	"m_motionGraphs":
//	[
//	],
//	"m_motionGraphConfigs":
//	[
//	],
//	"m_sampleToConfig":
//	[
//	],
//	"m_hIsActiveScript":
//	{
//		"m_id": 4294967295
//	}
//}
class CMotionGraphGroup
{
	CMotionSearchDB m_searchDB;
	CUtlVector< CSmartPtr< CMotionGraph > > m_motionGraphs;
	CUtlVector< CMotionGraphConfig > m_motionGraphConfigs;
	CUtlVector< int32 > m_sampleToConfig;
	AnimScriptHandle m_hIsActiveScript;
};
