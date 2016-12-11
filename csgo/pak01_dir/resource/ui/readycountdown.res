"Resource/UI/ReadyCountdown.res"
{
	"ready_countdown"
	{
		"ControlName"	"Frame"
		"fieldName"		"ready_countdown"
		"xpos"			"c-57"
		"ypos"			"72"
		"wide"			"115"
		"tall"			"28"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
	}

	"Background"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"Background"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"115"
		"tall"			"28"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack50_outlineGrey"
		"drawcolor"		"255 255 255 255"
		"src_corner_height"		"16"			// pixels inside the image
		"src_corner_width"		"16"
		"draw_corner_width"		"3"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"3"	
	}
	
	"BackgroundFill"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"BackgroundFill"
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"115"
		"tall"				"28"
		"visible"			"1"
		"enabled"			"1"
		"scaleImage"		"1"	
		"fillcolor" 		"0 0 0 200"
		"zpos"				"-2"
	}

	"Seconds_1"
	{
		"ControlName"		"Label"
		"fieldName"			"Seconds_1"
		"xpos"				"32"
		"ypos"				"2"
		"wide"				"75"
		"tall"				"12"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"#L4D_s_team_ready_seconds_1"
		"textAlignment"		"west"
		"font"				"MenuSubTitle"
	}

	"Seconds_2"
	{
		"ControlName"		"Label"
		"fieldName"			"Seconds_2"
		"xpos"				"32"
		"ypos"				"14"
		"wide"				"75"
		"tall"				"12"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"#L4D_s_team_ready_seconds_2"
		"textAlignment"		"west"
		"font"				"MenuSubTitle"
	}

	"Countdown"
	{
		"ControlName"		"Label"
		"fieldName"			"Countdown"
		"xpos"				"5"
		"ypos"				"2"
		"wide"				"24"
		"tall"				"24"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			""
		"textAlignment"		"center"
		"fgcolor_override"	"255 255 255 255"
		"font"				"MenuTitle"
	}
}
