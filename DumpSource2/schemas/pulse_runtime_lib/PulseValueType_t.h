enum PulseValueType_t : uint32_t
{
	// MPropertyFriendlyName = "Void"
	PVAL_INVALID = -1,
	// MPropertyFriendlyName = "Boolean"
	PVAL_BOOL = 0,
	// MPropertyFriendlyName = "Integer"
	PVAL_INT = 1,
	// MPropertyFriendlyName = "Float"
	PVAL_FLOAT = 2,
	// MPropertyFriendlyName = "String"
	PVAL_STRING = 3,
	// MPropertyFriendlyName = "Vector3"
	PVAL_VEC3 = 4,
	// MPropertyFriendlyName = "Transform"
	PVAL_TRANSFORM = 5,
	// MPropertyFriendlyName = "Color"
	PVAL_COLOR_RGB = 6,
	// MPropertyFriendlyName = "Entity Handle"
	PVAL_EHANDLE = 7,
	// MPropertyFriendlyName = "Resource"
	PVAL_RESOURCE = 8,
	// MPropertyFriendlyName = "SoundEvent Instance Handle"
	PVAL_SNDEVT_GUID = 9,
	// MPropertyFriendlyName = "SoundEvent"
	PVAL_SNDEVT_NAME = 10,
	// MPropertyFriendlyName = "Entity Name"
	PVAL_ENTITY_NAME = 11,
	// MPropertyFriendlyName = "Opaque Handle"
	PVAL_OPAQUE_HANDLE = 12,
	// MPropertyFriendlyName = "Typesafe Int"
	PVAL_TYPESAFE_INT = 13,
	// MPropertySuppressEnumerator
	PVAL_CURSOR_FLOW = 14,
	// MPropertyFriendlyName = "Any"
	PVAL_ANY = 15,
	// MPropertyFriendlyName = "Schema Enum"
	PVAL_SCHEMA_ENUM = 16,
	// MPropertyFriendlyName = "Panorama Panel Handle"
	PVAL_PANORAMA_PANEL_HANDLE = 17,
	// MPropertyFriendlyName = "Test Handle"
	PVAL_TEST_HANDLE = 18,
	// MPropertySuppressEnumerator
	PVAL_COUNT = 19,
};
