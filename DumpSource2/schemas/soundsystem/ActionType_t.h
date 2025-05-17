enum ActionType_t : uint32_t
{
	// MPropertyFriendlyName = "None"
	SOS_ACTION_NONE = 0,
	// MPropertyFriendlyName = "Limiter"
	SOS_ACTION_LIMITER = 1,
	// MPropertyFriendlyName = "Time Limiter"
	SOS_ACTION_TIME_LIMIT = 2,
	// MPropertyFriendlyName = "Timed Block Limiter"
	SOS_ACTION_TIME_BLOCK_LIMITER = 3,
	// MPropertyFriendlyName = "Set Sound Event Parameter"
	SOS_ACTION_SET_SOUNDEVENT_PARAM = 4,
	// MPropertyFriendlyName = "Soundevent Cluster"
	SOS_ACTION_SOUNDEVENT_CLUSTER = 5,
	// MPropertyFriendlyName = "Soundevent Priority"
	SOS_ACTION_SOUNDEVENT_PRIORITY = 6,
	// MPropertyFriendlyName = "Count Envelope"
	SOS_ACTION_COUNT_ENVELOPE = 7,
	// MPropertyFriendlyName = "Soundevent Count"
	SOS_ACTION_SOUNDEVENT_COUNT = 8,
	// MPropertyFriendlyName = "Soundevent Min/Max Values"
	SOS_ACTION_SOUNDEVENT_MIN_MAX_VALUES = 9,
};
