// MGetKV3ClassDefaults = {
//	"m_previewModel": "",
//	"m_nModSpecificData": 0,
//	"m_groundType": "PET_GROUND_GRID",
//	"m_sequenceName": "",
//	"m_nFireParticleOnSequenceFrame": 0,
//	"m_hitboxSetName": "",
//	"m_materialGroupName": "",
//	"m_vecBodyGroups":
//	[
//	],
//	"m_flPlaybackSpeed": 1.000000,
//	"m_flParticleSimulationRate": 1.000000,
//	"m_bShouldDrawHitboxes": false,
//	"m_bShouldDrawAttachments": false,
//	"m_bShouldDrawAttachmentNames": false,
//	"m_bShouldDrawControlPointAxes": false,
//	"m_bAnimationNonLooping": false,
//	"m_bSequenceNameIsAnimClipPath": false,
//	"m_vecPreviewGravity":
//	[
//		0.000000,
//		0.000000,
//		-800.000000
//	]
//}
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
	bool m_bSequenceNameIsAnimClipPath;
	Vector m_vecPreviewGravity;
};
