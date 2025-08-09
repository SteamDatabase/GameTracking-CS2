// MGetKV3ClassDefaults = {
//	"m_nFlags": 0,
//	"m_name": "",
//	"m_localHAnimArray":
//	[
//	],
//	"m_includedGroupArray":
//	[
//	],
//	"m_directHSeqGroup": "",
//	"m_decodeKey":
//	{
//		"m_name": "",
//		"m_boneArray":
//		[
//		],
//		"m_userArray":
//		[
//		],
//		"m_morphArray":
//		[
//		],
//		"m_nChannelElements": 0,
//		"m_dataChannelArray":
//		[
//		]
//	},
//	"m_szScripts":
//	[
//	],
//	"m_AdditionalExtRefs":
//	[
//	]
//}
class CAnimationGroup
{
	uint32 m_nFlags;
	CBufferString m_name;
	// MKV3TransferName = "m_localHAnimArray"
	CUtlVector< CStrongHandle< InfoForResourceTypeCAnimData > > m_localHAnimArray_Handle;
	// MKV3TransferName = "m_includedGroupArray"
	CUtlVector< CStrongHandle< InfoForResourceTypeCAnimationGroup > > m_includedGroupArray_Handle;
	// MKV3TransferName = "m_directHSeqGroup"
	CStrongHandle< InfoForResourceTypeCSequenceGroupData > m_directHSeqGroup_Handle;
	CAnimKeyData m_decodeKey;
	CUtlVector< CBufferString > m_szScripts;
	CUtlVector< CStrongHandleVoid > m_AdditionalExtRefs;
};
