// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionSoundeventCountSchema",
//	"m_name": "None",
//	"m_actionType": "SOS_ACTION_SOUNDEVENT_COUNT",
//	"m_actionInstanceType": "SOS_ACTION_SOUNDEVENT_COUNT",
//	"m_bExcludeStoppedSounds": true,
//	"m_strCountKeyName": "current_count"
//}
// M_LEGACY_OptInToSchemaPropertyDomain
class CSosGroupActionSoundeventCountSchema : public CSosGroupActionSchema
{
	// MPropertyFriendlyName = "Exclude Stopped Sounds from Count"
	bool m_bExcludeStoppedSounds;
	// MPropertyFriendlyName = "Result Current Count"
	CUtlString m_strCountKeyName;
};
