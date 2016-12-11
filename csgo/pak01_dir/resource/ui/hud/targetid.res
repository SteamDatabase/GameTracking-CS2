"Resource/UI/HUD/TargetID.res"
{
	"TargetID"
	{
		"ControlName"	"DoNotAutoCreate"
		"fieldName"		"TargetID"

		"normal_fgcolor"	"0 0 0 255"
		"normal_bgcolor"	"255 255 255 255"

		"downgrade_fgcolor"	"0 0 0 255"
		"downgrade_bgcolor"	"128 128 128 255"
	}

	// TargetIDLabel's colors are controlled by the values above
	// TargetIDLabel's positions are driven by TargetIDReviveProgress and TargetIDNormal anims (HudAnimations.txt)
	"TargetIDLabel"
	{
		"ControlName"	"Label"
		"fieldName"		"TargetIDLabel"
		"xpos"			"c-10"
		"ypos"			"c+20"
		"wide"			"290"
		"tall"			"25"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		""
		"textAlignment"	"west"
		"dulltext"		"0"
		"brighttext"	"0"
		"font"			"TargetID"
		"fgcolor_override"	"255 255 255 255"
		"bgcolor_override"	"0 0 0 0"
	}
}