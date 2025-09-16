// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionSoundeventCountSchema",
//	"m_bExcludeStoppedSounds": true,
//	"m_strCountKeyName": "current_count"
//}
// MPropertyFriendlyName = "Soundevent Count"
class CSosGroupActionSoundeventCountSchema : public CSosGroupActionSchema
{
	// MPropertyFriendlyName = "Exclude Stopped Sounds from Count"
	bool m_bExcludeStoppedSounds;
	// MPropertyFriendlyName = "Result Current Count"
	CUtlString m_strCountKeyName;
};
