// MGetKV3ClassDefaults = {
//	"_class": "CAudioAnimTag",
//	"m_name": "Unnamed Tag",
//	"m_sComment": "",
//	"m_group": "",
//	"m_tagID":
//	{
//		"m_id": 4294967295
//	},
//	"m_bIsReferenced": false,
//	"m_clipName": "",
//	"m_attachmentName": "",
//	"m_flVolume": 1.000000,
//	"m_bStopWhenTagEnds": false,
//	"m_bStopWhenGraphEnds": true,
//	"m_bPlayOnServer": true,
//	"m_bPlayOnClient": true
//}
// MPropertyFriendlyName = "Audio Tag"
class CAudioAnimTag : public CAnimTagBase
{
	// MPropertyFriendlyName = "Sound Event"
	// MPropertyAttributeEditor = "SoundPicker()"
	CUtlString m_clipName;
	// MPropertyFriendlyName = "Attachment"
	// MPropertyAttributeChoiceName = "Attachment"
	CUtlString m_attachmentName;
	// MPropertyFriendlyName = "Volume"
	// MPropertyAttributeRange = "0 1"
	float32 m_flVolume;
	// MPropertyFriendlyName = "Stop on Tag End"
	bool m_bStopWhenTagEnds;
	// MPropertyFriendlyName = "Stop When Graph Destroyed"
	bool m_bStopWhenGraphEnds;
	// MPropertyFriendlyName = "Play on Server"
	bool m_bPlayOnServer;
	// MPropertyFriendlyName = "Play on Client"
	bool m_bPlayOnClient;
};
