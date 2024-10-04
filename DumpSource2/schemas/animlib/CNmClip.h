class CNmClip
{
	CStrongHandle< InfoForResourceTypeCNmSkeleton > m_skeleton;
	uint32 m_nNumFrames;
	float32 m_flDuration;
	CUtlBinaryBlock m_compressedPoseData;
	CUtlVector< NmCompressionSettings_t > m_trackCompressionSettings;
	CUtlVector< uint32 > m_compressedPoseOffsets;
	CNmSyncTrack m_syncTrack;
	CNmRootMotionData m_rootMotion;
	bool m_bIsAdditive;
};
