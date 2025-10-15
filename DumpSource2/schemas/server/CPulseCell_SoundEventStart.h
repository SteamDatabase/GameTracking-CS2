// MGetKV3ClassDefaults = {
//	"_class": "CPulseCell_SoundEventStart",
//	"m_nEditorNodeID": -1,
//	"m_Type": "SOUNDEVENT_START_PLAYER"
//}
// MPropertyFriendlyName = "Start Sound Event"
// MPropertyDescription = "Starts a sound event, returns a handle that can be used to stop it. Keywords: create, sound, event, audio"
class CPulseCell_SoundEventStart : public CPulseCell_BaseFlow
{
	SoundEventStartType_t m_Type;
};
