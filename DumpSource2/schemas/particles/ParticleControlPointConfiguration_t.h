// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_drivers":
//	[
//	],
//	"m_previewState":
//	{
//		"m_previewModel": "",
//		"m_nModSpecificData": 0,
//		"m_groundType": "PET_GROUND_GRID",
//		"m_sequenceName": "",
//		"m_nFireParticleOnSequenceFrame": 0,
//		"m_hitboxSetName": "",
//		"m_materialGroupName": "",
//		"m_vecBodyGroups":
//		[
//		],
//		"m_flPlaybackSpeed": 1.000000,
//		"m_flParticleSimulationRate": 1.000000,
//		"m_bShouldDrawHitboxes": false,
//		"m_bShouldDrawAttachments": false,
//		"m_bShouldDrawAttachmentNames": false,
//		"m_bShouldDrawControlPointAxes": false,
//		"m_bAnimationNonLooping": false,
//		"m_bSequenceNameIsAnimClipPath": false,
//		"m_vecPreviewGravity":
//		[
//			0.000000,
//			0.000000,
//			-800.000000
//		]
//	}
//}
class ParticleControlPointConfiguration_t
{
	CUtlString m_name;
	CUtlVector< ParticleControlPointDriver_t > m_drivers;
	ParticlePreviewState_t m_previewState;
};
