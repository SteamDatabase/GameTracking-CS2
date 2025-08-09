// MGetKV3ClassDefaults = {
//	"m_nNodeType": "NODE_TYPE_INVALID",
//	"name": "",
//	"inventory_image_data":
//	{
//		"map":
//		{
//			"map_name": "ui/icon_generation_basic_nuke_bombsitea",
//			"map_rotation": 0.000000
//		},
//		"item":
//		{
//			"position":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"angle":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"pose_sequence": ""
//		},
//		"camera":
//		{
//			"angle":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"fov": 45.000000,
//			"znear": 4.000000,
//			"zfar": 1000.000000,
//			"target":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"target_nudge":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"orbit_distance": 0.000000
//		},
//		"lightsun":
//		{
//			"color":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"angle":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"brightness": 1.000000
//		},
//		"lightfill":
//		{
//			"color":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"angle":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"brightness": 1.000000
//		},
//		"light0":
//		{
//			"color":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"angle":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"brightness": 0.000000,
//			"orbit_distance": 1.000000
//		},
//		"light1":
//		{
//			"color":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"angle":
//			[
//				0.000000,
//				0.000000,
//				0.000000
//			],
//			"brightness": 0.000000,
//			"orbit_distance": 1.000000
//		}
//	}
//}
// MVDataRoot
// MVDataOutlinerDetailExpr (UNKNOWN FOR PARSER)
// MVDataOverlayType = 1
// MVDataPreviewWidget (UNKNOWN FOR PARSER)
// MVDataHideNodeClass
// MVDataOutlinerLeafNameFn (UNKNOWN FOR PARSER)
// MVDataOutlinerLeafColorFn (UNKNOWN FOR PARSER)
// MVDataOutlinerLeafDetailFn (UNKNOWN FOR PARSER)
// MVDataVirtualNodeFactoryFn (UNKNOWN FOR PARSER)
// MVDataPreLoadFixupFn (UNKNOWN FOR PARSER)
// MVDataPostSaveFixupFn (UNKNOWN FOR PARSER)
class CInventoryImageData
{
	// MPropertySuppressField
	InventoryNodeType_t m_nNodeType;
	// MPropertyFriendlyName = "Item Name"
	// MPropertyReadOnly
	// MPropertyReadonlyExpr (UNKNOWN FOR PARSER)
	// MPropertySuppressExpr = "name == """
	CUtlString name;
	// MPropertyFriendlyName = "Inventory Image Data"
	// MPropertyAutoExpandSelf
	inv_image_data_t inventory_image_data;
};
