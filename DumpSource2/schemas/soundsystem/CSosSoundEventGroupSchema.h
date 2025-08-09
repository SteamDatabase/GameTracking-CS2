// MGetKV3ClassDefaults = {
//	"m_name": "New Group",
//	"m_nType": "SOS_GROUPTYPE_DYNAMIC",
//	"m_bIsBlocking": false,
//	"m_nBlockMaxCount": 0,
//	"m_bInvertMatch": false,
//	"m_matchPattern":
//	{
//		"_class": "CSosGroupMatchPattern",
//		"m_bMatchEventName": false,
//		"m_bMatchEventSubString": false,
//		"m_bMatchEntIndex": false,
//		"m_bMatchOpvar": false,
//		"m_bMatchString": false,
//		"m_matchSoundEventName": "",
//		"m_matchSoundEventSubString": "",
//		"m_flEntIndex": -1.000000,
//		"m_flOpvar": -1.000000,
//		"m_opvarString": ""
//	},
//	"m_branchPattern":
//	{
//		"_class": "CSosGroupBranchPattern",
//		"m_bMatchEventName": false,
//		"m_bMatchEventSubString": false,
//		"m_bMatchEntIndex": false,
//		"m_bMatchOpvar": false,
//		"m_bMatchString": false
//	},
//	"m_flLifeSpanTime": -1.000000,
//	"m_vActions":
//	[
//		{
//			"_class": "CSosGroupActionSchema",
//			"m_name": "None",
//			"m_actionType": "SOS_ACTION_NONE",
//			"m_actionInstanceType": "SOS_ACTION_NONE"
//		},
//		{
//			"_class": "CSosGroupActionSchema",
//			"m_name": "None",
//			"m_actionType": "SOS_ACTION_NONE",
//			"m_actionInstanceType": "SOS_ACTION_NONE"
//		},
//		{
//			"_class": "CSosGroupActionSchema",
//			"m_name": "None",
//			"m_actionType": "SOS_ACTION_NONE",
//			"m_actionInstanceType": "SOS_ACTION_NONE"
//		},
//		{
//			"_class": "CSosGroupActionSchema",
//			"m_name": "None",
//			"m_actionType": "SOS_ACTION_NONE",
//			"m_actionInstanceType": "SOS_ACTION_NONE"
//		}
//	]
//}
// MPropertyElementNameFn (UNKNOWN FOR PARSER)
// M_LEGACY_OptInToSchemaPropertyDomain
class CSosSoundEventGroupSchema
{
	// MPropertyFriendlyName = "Group Name"
	CUtlString m_name;
	// MPropertyFriendlyName = "Group Type"
	SosGroupType_t m_nType;
	// MPropertyFriendlyName = "Blocks Events"
	bool m_bIsBlocking;
	// MPropertyFriendlyName = "Block Max Count"
	int32 m_nBlockMaxCount;
	// MPropertyFriendlyName = "Invert Match"
	bool m_bInvertMatch;
	// MPropertyFriendlyName = "Match Rules"
	CSosGroupMatchPattern m_matchPattern;
	// MPropertyFriendlyName = "Branch Rules"
	CSosGroupBranchPattern m_branchPattern;
	// MPropertyFriendlyName = "Member Lifespan Time"
	float32 m_flLifeSpanTime;
	// MPropertyFriendlyName = "Actions"
	CSosGroupActionSchema*[4] m_vActions;
};
