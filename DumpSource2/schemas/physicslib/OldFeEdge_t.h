// MGetKV3ClassDefaults = {
//	"m_flK":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"invA": 0.000000,
//	"t": 0.000000,
//	"flThetaRelaxed": 0.000000,
//	"flThetaFactor": 0.000000,
//	"c01": 0.000000,
//	"c02": 0.000000,
//	"c03": 0.000000,
//	"c04": 0.000000,
//	"flAxialModelDist": 0.000000,
//	"flAxialModelWeights":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"m_nNode":
//	[
//		0,
//		0,
//		0,
//		0
//	]
//}
class OldFeEdge_t
{
	float32[3] m_flK;
	float32 invA;
	float32 t;
	float32 flThetaRelaxed;
	float32 flThetaFactor;
	float32 c01;
	float32 c02;
	float32 c03;
	float32 c04;
	float32 flAxialModelDist;
	float32[4] flAxialModelWeights;
	uint16[4] m_nNode;
};
