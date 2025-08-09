// MGetKV3ClassDefaults = {
//	"m_boneArray":
//	[
//	],
//	"m_morphArray":
//	[
//	],
//	"m_userArray":
//	[
//	],
//	"m_bHasRotationBitArray":
//	[
//	],
//	"m_bHasMovementBitArray":
//	[
//	],
//	"m_bHasMorphBitArray":
//	[
//	],
//	"m_bHasUserBitArray":
//	[
//	]
//}
class CAnimEncodeDifference
{
	CUtlVector< CAnimBoneDifference > m_boneArray;
	CUtlVector< CAnimMorphDifference > m_morphArray;
	CUtlVector< CAnimUserDifference > m_userArray;
	CUtlVector< uint8 > m_bHasRotationBitArray;
	CUtlVector< uint8 > m_bHasMovementBitArray;
	CUtlVector< uint8 > m_bHasMorphBitArray;
	CUtlVector< uint8 > m_bHasUserBitArray;
};
