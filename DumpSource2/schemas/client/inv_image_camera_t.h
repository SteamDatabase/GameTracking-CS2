// MGetKV3ClassDefaults = {
//	"angle":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"fov": 45.000000,
//	"znear": 4.000000,
//	"zfar": 1000.000000,
//	"target":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"target_nudge":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"orbit_distance": 0.000000
//}
class inv_image_camera_t
{
	// MPropertyFriendlyName = "Angle"
	// MCustomFGDMetadata = "{ reset_to_default_icon = true }"
	QAngle angle;
	// MPropertyFriendlyName = "FOV"
	// MCustomFGDMetadata = "{ reset_to_default_icon = true }"
	// MPropertyAttributeRange = "0 360"
	float32 fov;
	// MPropertyFriendlyName = "Z Near"
	// MCustomFGDMetadata = "{ reset_to_default_icon = true }"
	// MPropertyAttributeRange = "0 1000"
	float32 znear;
	// MPropertyFriendlyName = "Z Far"
	// MCustomFGDMetadata = "{ reset_to_default_icon = true }"
	// MPropertyAttributeRange = "0 1000"
	float32 zfar;
	// MPropertyFriendlyName = "Target"
	// MCustomFGDMetadata = "{ reset_to_default_icon = true }"
	Vector target;
	// MPropertyFriendlyName = "Target Nudge"
	// MCustomFGDMetadata = "{ reset_to_default_icon = true }"
	Vector target_nudge;
	// MPropertyFriendlyName = "Orbit Distance"
	// MCustomFGDMetadata = "{ reset_to_default_icon = true }"
	// MPropertyAttributeRange = "0 1000"
	float32 orbit_distance;
};
