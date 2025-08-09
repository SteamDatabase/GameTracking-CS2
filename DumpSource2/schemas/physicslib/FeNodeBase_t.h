// MGetKV3ClassDefaults = {
//	"nNode": 0,
//	"nDummy":
//	[
//		0,
//		0,
//		0
//	],
//	"nNodeX0": 0,
//	"nNodeX1": 0,
//	"nNodeY0": 0,
//	"nNodeY1": 0,
//	"qAdjust":
//	[
//		0.000000,
//		0.000000,
//		0.000000,
//		0.000000
//	]
//}
class FeNodeBase_t
{
	uint16 nNode;
	uint16[3] nDummy;
	uint16 nNodeX0;
	uint16 nNodeX1;
	uint16 nNodeY0;
	uint16 nNodeY1;
	QuaternionStorage qAdjust;
};
