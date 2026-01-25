// MGetKV3ClassDefaults = {
//	"_class": "CFootstepLandedAnimTag",
//	"m_name": "Unnamed Tag",
//	"m_sComment": "",
//	"m_group": "",
//	"m_tagID":
//	{
//		"m_id": 4294967295
//	},
//	"m_bIsReferenced": false,
//	"m_FootstepType": "FOOTSOUND_Left",
//	"m_OverrideSoundName": "",
//	"m_DebugAnimSourceString": "",
//	"m_BoneName": "",
//	"m_footstepJumpPhase": "Unknown"
//}
// MPropertyFriendlyName = "FootstepLanded Tag"
class CFootstepLandedAnimTag : public CAnimTagBase
{
	// MPropertyFriendlyName = "Footstep Type"
	FootstepLandedFootSoundType_t m_FootstepType;
	// MPropertyFriendlyName = "Override Sound"
	// MPropertyAttributeChoiceName = "Sound"
	CUtlString m_OverrideSoundName;
	// MPropertyFriendlyName = "Debug Name"
	CUtlString m_DebugAnimSourceString;
	// MPropertyFriendlyName = "Bone Name"
	// MPropertyAttributeChoiceName = "Bone"
	CUtlString m_BoneName;
	// MPropertyFriendlyName = "Jump Phase"
	FootstepJumpPhase_t m_footstepJumpPhase;
};
