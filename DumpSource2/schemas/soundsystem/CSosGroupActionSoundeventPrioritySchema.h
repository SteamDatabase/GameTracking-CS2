// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionSoundeventPrioritySchema",
//	"m_name": "None",
//	"m_actionType": "SOS_ACTION_SOUNDEVENT_PRIORITY",
//	"m_actionInstanceType": "SOS_ACTION_SOUNDEVENT_PRIORITY",
//	"m_priorityValue": "priority_value",
//	"m_priorityVolumeScalar": "priority_volume_scalar",
//	"m_priorityContributeButDontRead": "priority_contribute_dont_read",
//	"m_bPriorityReadButDontContribute": "priority_read_dont_contribute"
//}
// M_LEGACY_OptInToSchemaPropertyDomain
class CSosGroupActionSoundeventPrioritySchema : public CSosGroupActionSchema
{
	// MPropertyFriendlyName = "Priority Value, typically 0.0 to 1.0"
	CUtlString m_priorityValue;
	// MPropertyFriendlyName = "Priority-Based Volume Multiplier, 0.0 to 1.0"
	CUtlString m_priorityVolumeScalar;
	// MPropertyFriendlyName = "Contribute to the priority system, but volume is unaffected by it (bool)"
	CUtlString m_priorityContributeButDontRead;
	// MPropertyFriendlyName = "Don't contribute to the priority system, but volume is affected by it (bool)"
	CUtlString m_bPriorityReadButDontContribute;
};
