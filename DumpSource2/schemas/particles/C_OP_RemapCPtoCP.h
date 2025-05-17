// MGetKV3ClassDefaults (UNKNOWN FOR PARSER)
class C_OP_RemapCPtoCP : public CParticleFunctionPreEmission
{
	// MPropertyFriendlyName = "input control point number"
	int32 m_nInputControlPoint;
	// MPropertyFriendlyName = "output control point number"
	int32 m_nOutputControlPoint;
	// MPropertyFriendlyName = "input field"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nInputField;
	// MPropertyFriendlyName = "output field"
	// MPropertyAttributeChoiceName = "vector_component"
	int32 m_nOutputField;
	// MPropertyFriendlyName = "input minimum"
	float32 m_flInputMin;
	// MPropertyFriendlyName = "input maximum"
	float32 m_flInputMax;
	// MPropertyFriendlyName = "output minimum"
	float32 m_flOutputMin;
	// MPropertyFriendlyName = "output maximum"
	float32 m_flOutputMax;
	// MPropertyFriendlyName = "use the derivative"
	bool m_bDerivative;
	// MPropertyFriendlyName = "interpolation"
	float32 m_flInterpRate;
};
