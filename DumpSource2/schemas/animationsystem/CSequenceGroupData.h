// MGetKV3ClassDefaults = {
//	"m_sName": "",
//	"m_nFlags": 0,
//	"m_localSequenceNameArray":
//	[
//	],
//	"m_localS1SeqDescArray":
//	[
//	],
//	"m_localMultiSeqDescArray":
//	[
//	],
//	"m_localSynthAnimDescArray":
//	[
//	],
//	"m_localCmdSeqDescArray":
//	[
//	],
//	"m_localBoneMaskArray":
//	[
//	],
//	"m_localScaleSetArray":
//	[
//	],
//	"m_localBoneNameArray":
//	[
//	],
//	"m_localNodeName": "",
//	"m_localPoseParamArray":
//	[
//	],
//	"m_keyValues": null,
//	"m_localIKAutoplayLockArray":
//	[
//	]
//}
class CSequenceGroupData
{
	CBufferString m_sName;
	uint32 m_nFlags;
	CUtlVector< CBufferString > m_localSequenceNameArray;
	CUtlVector< CSeqS1SeqDesc > m_localS1SeqDescArray;
	CUtlVector< CSeqS1SeqDesc > m_localMultiSeqDescArray;
	CUtlVector< CSeqSynthAnimDesc > m_localSynthAnimDescArray;
	CUtlVector< CSeqCmdSeqDesc > m_localCmdSeqDescArray;
	CUtlVector< CSeqBoneMaskList > m_localBoneMaskArray;
	CUtlVector< CSeqScaleSet > m_localScaleSetArray;
	CUtlVector< CBufferString > m_localBoneNameArray;
	CBufferString m_localNodeName;
	CUtlVector< CSeqPoseParamDesc > m_localPoseParamArray;
	KeyValues3 m_keyValues;
	CUtlVector< CSeqIKLock > m_localIKAutoplayLockArray;
};
