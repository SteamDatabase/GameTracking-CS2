// MGetKV3ClassDefaults = {
//	"m_skeleton": "",
//	"m_nNumFrames": 0,
//	"m_flDuration": 0.000000,
//	"m_compressedPoseData": "[BINARY BLOB]",
//	"m_trackCompressionSettings":
//	[
//	],
//	"m_compressedPoseOffsets":
//	[
//	],
//	"m_secondaryAnimations":
//	[
//	],
//	"m_syncTrack":
//	{
//		"m_syncEvents":
//		[
//			{
//				"m_ID": "",
//				"m_startTime":
//				{
//					"m_flValue": 0.000000
//				},
//				"m_duration":
//				{
//					"m_flValue": 1.000000
//				}
//			}
//		],
//		"m_nStartEventOffset": 0
//	},
//	"m_rootMotion":
//	{
//		"m_transforms":
//		[
//		],
//		"m_nNumFrames": 0,
//		"m_flAverageLinearVelocity": 0.000000,
//		"m_flAverageAngularVelocityRadians": 0.000000,
//		"m_totalDelta":
//		[
//			0.000000,
//			0.000000,
//			0.000000,
//			0.000000,
//			0.000000,
//			0.000000,
//			0.000000,
//			0.000000
//		]
//	},
//	"m_bIsAdditive": false,
//	"m_modelSpaceSamplingChain":
//	[
//	],
//	"m_modelSpaceBoneSamplingIndices":
//	[
//	],
//	"m_events":
//	[
//	]
//}
class CNmClip
{
	CStrongHandle< InfoForResourceTypeCNmSkeleton > m_skeleton;
	uint32 m_nNumFrames;
	float32 m_flDuration;
	CUtlBinaryBlock m_compressedPoseData;
	CUtlVector< NmCompressionSettings_t > m_trackCompressionSettings;
	CUtlVector< uint32 > m_compressedPoseOffsets;
	CUtlVectorFixedGrowable< CNmClip*, 1 > m_secondaryAnimations;
	CNmSyncTrack m_syncTrack;
	CNmRootMotionData m_rootMotion;
	bool m_bIsAdditive;
	CUtlVector< CNmClip::ModelSpaceSamplingChainLink_t > m_modelSpaceSamplingChain;
	CUtlVector< int32 > m_modelSpaceBoneSamplingIndices;
};
