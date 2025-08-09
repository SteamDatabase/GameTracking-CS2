// MGetKV3ClassDefaults = {
//	"color":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"angle":
//	[
//		0.000000,
//		0.000000,
//		0.000000
//	],
//	"brightness": 0.000000,
//	"orbit_distance": 1.000000
//}
class inv_image_light_barn_t
{
	// MPropertyFriendlyName = "Color"
	// MPropertyAttributeEditor = "VectorColor()"
	// MCustomFGDMetadata = "{ reset_to_default_icon = true }"
	Vector color;
	// MPropertyFriendlyName = "Angle"
	// MCustomFGDMetadata = "{ reset_to_default_icon = true }"
	QAngle angle;
	// MPropertyFriendlyName = "Brightness"
	// MCustomFGDMetadata = "{ reset_to_default_icon = true }"
	// MPropertyAttributeRange = "0 10"
	float32 brightness;
	// MPropertyFriendlyName = "Orbit Distance"
	// MCustomFGDMetadata = "{ reset_to_default_icon = true }"
	// MPropertyAttributeRange = "0 1000"
	float32 orbit_distance;
};
