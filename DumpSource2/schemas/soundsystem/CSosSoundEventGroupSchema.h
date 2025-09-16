// MGetKV3ClassDefaults = {
//	"m_nGroupType": "SOS_GROUPTYPE_DYNAMIC",
//	"m_bBlocksEvents": false,
//	"m_nBlockMaxCount": 0,
//	"m_flMemberLifespanTime": -1.000000,
//	"m_bInvertMatch": false,
//	"m_Behavior_EventName": "kIgnore",
//	"m_matchSoundEventName": "",
//	"m_bMatchEventSubString": false,
//	"m_matchSoundEventSubString": "",
//	"m_Behavior_EntIndex": "kIgnore",
//	"m_flEntIndex": -1.000000,
//	"m_Behavior_Opvar": "kIgnore",
//	"m_flOpvar": -1.000000,
//	"m_Behavior_String": "kIgnore",
//	"m_opvarString": "",
//	"m_vActions":
//	[
//	]
//}
// MVDataRoot
class CSosSoundEventGroupSchema
{
	// MPropertyAttributeEditor = "Radio"
	SosGroupType_t m_nGroupType;
	// MPropertyStartGroup = "+Block Events"
	bool m_bBlocksEvents;
	// MPropertyReadonlyExpr (UNKNOWN FOR PARSER)
	int32 m_nBlockMaxCount;
	// MPropertyStartGroup = ""
	float32 m_flMemberLifespanTime;
	bool m_bInvertMatch;
	// MPropertyStartGroup = "+Event Name"
	// MPropertyAttributeEditor = "Radio"
	// MPropertyReadonlyExpr (UNKNOWN FOR PARSER)
	SosGroupFieldBehavior_t m_Behavior_EventName;
	// MPropertyReadonlyExpr (UNKNOWN FOR PARSER)
	CUtlString m_matchSoundEventName;
	// MPropertyStartGroup = "+Event SubString"
	bool m_bMatchEventSubString;
	// MPropertyReadonlyExpr (UNKNOWN FOR PARSER)
	CUtlString m_matchSoundEventSubString;
	// MPropertyStartGroup = "+Ent Index"
	// MPropertyAttributeEditor = "Radio"
	SosGroupFieldBehavior_t m_Behavior_EntIndex;
	// MPropertyReadonlyExpr (UNKNOWN FOR PARSER)
	float32 m_flEntIndex;
	// MPropertyStartGroup = "+OpVar Float"
	// MPropertySuppressExpr = "m_nGroupType == SOS_GROUPTYPE_STATIC"
	// MPropertyAttributeEditor = "Radio"
	SosGroupFieldBehavior_t m_Behavior_Opvar;
	// MPropertyReadonlyExpr (UNKNOWN FOR PARSER)
	// MPropertySuppressExpr = "m_nGroupType == SOS_GROUPTYPE_STATIC"
	float32 m_flOpvar;
	// MPropertyStartGroup = "+OpVar String"
	// MPropertySuppressExpr = "m_nGroupType == SOS_GROUPTYPE_STATIC"
	// MPropertyAttributeEditor = "Radio"
	SosGroupFieldBehavior_t m_Behavior_String;
	// MPropertyReadonlyExpr (UNKNOWN FOR PARSER)
	// MPropertySuppressExpr = "m_nGroupType == SOS_GROUPTYPE_STATIC"
	CUtlString m_opvarString;
	// MPropertyStartGroup = ""
	// MPropertyAutoExpandSelf
	CUtlVector< CSosGroupActionSchema* > m_vActions;
};
