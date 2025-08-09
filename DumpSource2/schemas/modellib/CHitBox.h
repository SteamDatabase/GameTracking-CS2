// MGetKV3ClassDefaults = {
//	"m_name": "",
//	"m_sSurfaceProperty": "",
//	"m_sBoneName": "",
//	"m_vMinBounds":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_vMaxBounds":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_flShapeRadius": 0.000000,
//	"m_nBoneNameHash": 0,
//	"m_nGroupId": 0,
//	"m_nShapeType": 0,
//	"m_bTranslationOnly": false,
//	"m_CRC": 0,
//	"m_cRenderColor":
//	[
//		255,
//		255,
//		255
//	],
//	"m_nHitBoxIndex": 0
//}
class CHitBox
{
	CUtlString m_name;
	CUtlString m_sSurfaceProperty;
	CUtlString m_sBoneName;
	Vector m_vMinBounds;
	Vector m_vMaxBounds;
	float32 m_flShapeRadius;
	uint32 m_nBoneNameHash;
	int32 m_nGroupId;
	uint8 m_nShapeType;
	bool m_bTranslationOnly;
	uint32 m_CRC;
	Color m_cRenderColor;
	uint16 m_nHitBoxIndex;
};
