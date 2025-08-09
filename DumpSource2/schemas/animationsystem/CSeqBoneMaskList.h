// MGetKV3ClassDefaults = {
//	"m_sName": "",
//	"m_nLocalBoneArray":
//	[
//	],
//	"m_flBoneWeightArray":
//	[
//	],
//	"m_flDefaultMorphCtrlWeight": 1.000000,
//	"m_morphCtrlWeightArray":
//	[
//	]
//}
class CSeqBoneMaskList
{
	CBufferString m_sName;
	CUtlVector< int16 > m_nLocalBoneArray;
	CUtlVector< float32 > m_flBoneWeightArray;
	float32 m_flDefaultMorphCtrlWeight;
	CUtlVector< std::pair< CBufferString, float32 > > m_morphCtrlWeightArray;
};
