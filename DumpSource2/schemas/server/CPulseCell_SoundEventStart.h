// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_SoundEventStart",
//	"m_nEditorNodeID": -1,
//	"m_Type": "SOUNDEVENT_START_PLAYER"
//}
// MPulseCellMethodBindings (UNKNOWN FOR PARSER)
// MPropertyFriendlyName = "Start Sound Event"
// MPropertyDescription = "Starts a sound event, returns a handle that can be used to stop it."
class CPulseCell_SoundEventStart : public CPulseCell_BaseFlow
{
	SoundEventStartType_t m_Type;
};
