"Resource/UI/Tips.res"
{
	"tips"
	{
		"ControlName"		"CTipPanel"
		"fieldName"		"tips"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"f0"
		"tall"			"450"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"PaintBackgroundType"	"2"
	}

//	"Background"
//	{
//		"ControlName"	"Panel"
//		"fieldName"		"Background"
//		"xpos"			"6"
//		"ypos"			"8"
//		"wide"			"310"
//		"tall"			"35"
//		"autoResize"	"1"
//		"pinCorner"		"0"
//		"visible"		"1"
//		"enabled"		"1"
//		"tabPosition"	"0"
//		"scaleimage"	"1"
//		"bgcolor_override"	"64 64 64 255"
//		"zpos"			"-2"
//		"paintbackground"	"1"
//	}

	"TipIcon"
	{
		"ControlName"		"CIconPanel"
		"fieldName"			"TipIcon"
		"icon"				"tip_hunter"
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"45"
		"tall"				"45"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"scaleimage"		"1"
		"iconcolor"			"255 255 255 255"
	}


	"TipText"
	{
		"ControlName"		"Label"
		"fieldName"			"TipText"
		"xpos"				"50"
		"ypos"				"0" [$WIN32]
		"ypos"				"8" [$X360]
		"wide"				"400" [$WIN32]
		"wide"				"300" [$X360]
		"tall"				"50" [$WIN32]
		"tall"				"35" [$X360]
		"wrap"				"1"
		"autoResize"		"1"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"Text"
		"textAlignment"		"west"
		"font"				"BodyText_medium"   [$WIN32]
		"font"				"Default"			[$X360]
//		"fgcolor_override"	"164 164 164 255"
		"zpos"				"40"
	}
}
