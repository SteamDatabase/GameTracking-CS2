// MGetKV3ClassDefaults = {
//	"_class": "CNmFrameSnapEvent",
//	"m_flStartTime":
//	{
//		"m_flValue": 0.000000
//	},
//	"m_flDuration":
//	{
//		"m_flValue": 0.000000
//	},
//	"m_syncID": "",
//	"m_bClientOnly": false,
//	"m_frameSnapMode": "Floor"
//}
class CNmFrameSnapEvent : public CNmEvent
{
	NmFrameSnapEventMode_t m_frameSnapMode;
};
