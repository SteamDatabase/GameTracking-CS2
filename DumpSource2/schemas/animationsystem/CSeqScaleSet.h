// MGetKV3ClassDefaults = {
//	"m_sName": "",
//	"m_bRootOffset": false,
//	"m_vRootOffset":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_nLocalBoneArray":
//	[
//	],
//	"m_flBoneScaleArray":
//	[
//	]
//}
class CSeqScaleSet
{
	CBufferString m_sName;
	bool m_bRootOffset;
	Vector m_vRootOffset;
	CUtlVector< int16 > m_nLocalBoneArray;
	CUtlVector< float32 > m_flBoneScaleArray;
};
