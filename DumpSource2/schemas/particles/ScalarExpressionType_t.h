enum ScalarExpressionType_t : uint32_t
{
	// MPropertyFriendlyName = "Uninitialized"
	SCALAR_EXPRESSION_UNINITIALIZED = -1,
	// MPropertyFriendlyName = "Add"
	SCALAR_EXPRESSION_ADD = 0,
	// MPropertyFriendlyName = "Subtract"
	SCALAR_EXPRESSION_SUBTRACT = 1,
	// MPropertyFriendlyName = "Multiply"
	SCALAR_EXPRESSION_MUL = 2,
	// MPropertyFriendlyName = "Divide"
	SCALAR_EXPRESSION_DIVIDE = 3,
	// MPropertyFriendlyName = "Input 1"
	SCALAR_EXPRESSION_INPUT_1 = 4,
	// MPropertyFriendlyName = "Min"
	SCALAR_EXPRESSION_MIN = 5,
	// MPropertyFriendlyName = "Max"
	SCALAR_EXPRESSION_MAX = 6,
	// MPropertyFriendlyName = "Mod"
	SCALAR_EXPRESSION_MOD = 7,
	// MPropertyFriendlyName = "Equal"
	SCALAR_EXPRESSION_EQUAL = 8,
	// MPropertyFriendlyName = "Greater Than"
	SCALAR_EXPRESSION_GT = 9,
	// MPropertyFriendlyName = "Less Than"
	SCALAR_EXPRESSION_LT = 10,
};
