// MGetKV3ClassDefaults = {
//	"_class": "CSosGroupActionSoundeventMinMaxValuesSchema",
//	"m_strQueryPublicFieldName": "min_max_query",
//	"m_strDelayPublicFieldName": "delay",
//	"m_bExcludeStoppedSounds": true,
//	"m_bExcludeDelayedSounds": true,
//	"m_bExcludeSoundsBelowThreshold": false,
//	"m_flExcludeSoundsMinThresholdValue": -1.000000,
//	"m_bExcludSoundsAboveThreshold": false,
//	"m_flExcludeSoundsMaxThresholdValue": -1.000000,
//	"m_strMinValueName": "min",
//	"m_strMaxValueName": "max"
//}
// MPropertyFriendlyName = "Soundevent Min/Max Values"
class CSosGroupActionSoundeventMinMaxValuesSchema : public CSosGroupActionSchema
{
	// MPropertyFriendlyName = "Public field name to query."
	CUtlString m_strQueryPublicFieldName;
	// MPropertyFriendlyName = "Public field 'delay' name."
	CUtlString m_strDelayPublicFieldName;
	// MPropertyFriendlyName = "Exclude stopped sounds from evaluation"
	bool m_bExcludeStoppedSounds;
	// MPropertyFriendlyName = "Exclude delayed sounds from evaluation"
	bool m_bExcludeDelayedSounds;
	// MPropertyFriendlyName = "Exclude sounds from evaluation less than or equal to a min value threshold."
	bool m_bExcludeSoundsBelowThreshold;
	// MPropertyFriendlyName = "The minimum threshold value to exclude sounds."
	float32 m_flExcludeSoundsMinThresholdValue;
	// MPropertyFriendlyName = "Exclude sounds from evaluation greater than or equal to a max value threshold."
	bool m_bExcludSoundsAboveThreshold;
	// MPropertyFriendlyName = "The maximum threshold value to exclude sounds."
	float32 m_flExcludeSoundsMaxThresholdValue;
	// MPropertyFriendlyName = "Min value property name"
	CUtlString m_strMinValueName;
	// MPropertyFriendlyName = "Max value property name"
	CUtlString m_strMaxValueName;
};
