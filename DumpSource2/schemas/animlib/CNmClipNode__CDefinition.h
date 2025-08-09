// MGetKV3ClassDefaults = {
//	"_class": "CNmClipNode::CDefinition",
//	"m_nNodeIdx": -1,
//	"m_nPlayInReverseValueNodeIdx": -1,
//	"m_nResetTimeValueNodeIdx": -1,
//	"m_flSpeedMultiplier": 1.000000,
//	"m_nStartSyncEventOffset": 0,
//	"m_bSampleRootMotion": true,
//	"m_bAllowLooping": false,
//	"m_nDataSlotIdx": -1
//}
class CNmClipNode::CDefinition : public CNmClipReferenceNode::CDefinition
{
	int16 m_nPlayInReverseValueNodeIdx;
	int16 m_nResetTimeValueNodeIdx;
	float32 m_flSpeedMultiplier;
	int32 m_nStartSyncEventOffset;
	bool m_bSampleRootMotion;
	bool m_bAllowLooping;
	int16 m_nDataSlotIdx;
};
