// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class ParticlePreviewState_t
{
	CUtlString m_previewModel;
	uint32 m_nModSpecificData;
	PetGroundType_t m_groundType;
	CUtlString m_sequenceName;
	int32 m_nFireParticleOnSequenceFrame;
	CUtlString m_hitboxSetName;
	CUtlString m_materialGroupName;
	CUtlVector< ParticlePreviewBodyGroup_t > m_vecBodyGroups;
	float32 m_flPlaybackSpeed;
	float32 m_flParticleSimulationRate;
	bool m_bShouldDrawHitboxes;
	bool m_bShouldDrawAttachments;
	bool m_bShouldDrawAttachmentNames;
	bool m_bShouldDrawControlPointAxes;
	bool m_bAnimationNonLooping;
	Vector m_vecPreviewGravity;
};
