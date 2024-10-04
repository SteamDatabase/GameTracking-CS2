class CAnimationGroup
{
	uint32 m_nFlags;
	CBufferString m_name;
	CUtlVector< CStrongHandle< InfoForResourceTypeCAnimData > > m_localHAnimArray_Handle;
	CUtlVector< CStrongHandle< InfoForResourceTypeCAnimationGroup > > m_includedGroupArray_Handle;
	CStrongHandle< InfoForResourceTypeCSequenceGroupData > m_directHSeqGroup_Handle;
	CAnimKeyData m_decodeKey;
	CUtlVector< CBufferString > m_szScripts;
	CUtlVector< CStrongHandleVoid > m_AdditionalExtRefs;
};
