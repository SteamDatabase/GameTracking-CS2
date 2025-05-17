// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
// MCellForDomain = "ServerPointEntity"
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPulseCellOutflowHookInfo (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Sound Event"
// MPropertyDescription = "Starts a sound event, returns a handle that can be used to stop it."
class CPulseCell_SoundEventStart : public CPulseCell_BaseFlow
{
	SoundEventStartType_t m_Type;
};
