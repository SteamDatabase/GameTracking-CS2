// MGetKV3ClassDefaults = {
//	"flWeight": 1.000000,
//	"flActivationDistance": 1.000000,
//	"flBias": 0.000000,
//	"flCurvature": 0.000000,
//	"nFlags": 0,
//	"nProbeNode": 0,
//	"targetNodes":
//	[
//	]
//}
class FeAntiTunnelProbeBuild_t
{
	float32 flWeight;
	float32 flActivationDistance;
	float32 flBias;
	float32 flCurvature;
	uint32 nFlags;
	uint16 nProbeNode;
	CUtlVector< uint16 > targetNodes;
};
