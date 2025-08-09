// MGetKV3ClassDefaults = {
//	"sName": "",
//	"nNameHash": 0,
//	"nColor": 0,
//	"nFlags": 0,
//	"nVertexBase": 0,
//	"nVertexCount": 0,
//	"nMapOffset": 0,
//	"nNodeListOffset": 0,
//	"vCenterOfMass":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"flVolumetricSolveStrength": 0.000000,
//	"nScaleSourceNode": -1,
//	"nNodeListCount": 0
//}
class FeVertexMapDesc_t
{
	CUtlString sName;
	uint32 nNameHash;
	uint32 nColor;
	uint32 nFlags;
	uint16 nVertexBase;
	uint16 nVertexCount;
	uint32 nMapOffset;
	uint32 nNodeListOffset;
	Vector vCenterOfMass;
	float32 flVolumetricSolveStrength;
	int16 nScaleSourceNode;
	uint16 nNodeListCount;
};
