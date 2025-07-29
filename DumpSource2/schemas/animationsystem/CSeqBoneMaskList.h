// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class CSeqBoneMaskList
{
	CBufferString m_sName;
	CUtlVector< int16 > m_nLocalBoneArray;
	CUtlVector< float32 > m_flBoneWeightArray;
	float32 m_flDefaultMorphCtrlWeight;
	CUtlVector< std::pair< CBufferString, float32 > > m_morphCtrlWeightArray;
};
