// MGetKV3ClassDefaults = {
//	"map":
//	{
//		"map_name": "ui/icon_generation_basic_nuke_bombsitea",
//		"map_rotation": 0.000000
//	},
//	"item":
//	{
//		"position":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"angle":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"pose_sequence": ""
//	},
//	"camera":
//	{
//		"angle":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"fov": 45.000000,
//		"znear": 4.000000,
//		"zfar": 1000.000000,
//		"target":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"target_nudge":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"orbit_distance": 0.000000
//	},
//	"lightsun":
//	{
//		"color":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"angle":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"brightness": 1.000000
//	},
//	"lightfill":
//	{
//		"color":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"angle":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"brightness": 1.000000
//	},
//	"light0":
//	{
//		"color":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"angle":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"brightness": 0.000000,
//		"orbit_distance": 1.000000
//	},
//	"light1":
//	{
//		"color":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"angle":
//		[
//			0.000000,
//			0.000000,
//			0.000000
//		],
//		"brightness": 0.000000,
//		"orbit_distance": 1.000000
//	},
//	"clearcolor":
//	{
//		"color":
//		[
//			0.200000,
//			0.200000,
//			0.200000
//		]
//	}
//}
class inv_image_data_t
{
	// MPropertyFriendlyName = "Map"
	// MPropertyAutoExpandSelf
	inv_image_map_t map;
	// MPropertyFriendlyName = "Item"
	// MPropertyAutoExpandSelf
	inv_image_item_t item;
	// MPropertyFriendlyName = "Camera"
	// MPropertyAutoExpandSelf
	inv_image_camera_t camera;
	// MPropertyFriendlyName = "Sun light"
	// MPropertyDescription = "Shadowed."
	// MPropertyAutoExpandSelf
	inv_image_light_sun_t lightsun;
	// MPropertyFriendlyName = "Fill light"
	// MPropertyDescription = "No Shadows."
	// MPropertyAutoExpandSelf
	inv_image_light_fill_t lightfill;
	// MPropertyFriendlyName = "Barn light 0"
	// MPropertyDescription = "Shadowed."
	// MPropertyAutoExpandSelf
	inv_image_light_barn_t light0;
	// MPropertyFriendlyName = "Barn light 1"
	// MPropertyDescription = "Shadowed."
	// MPropertyAutoExpandSelf
	inv_image_light_barn_t light1;
	// MPropertyFriendlyName = "Clear Color"
	// MPropertyDescription = ""
	// MPropertyAutoExpandSelf
	inv_image_clearcolor_t clearcolor;
};
