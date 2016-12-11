"Resource/UI/VsModeShutdown.res"
{
	"vs_shutting_down"
	{
		"ControlName"		"CFullscreenVersusModeScoreboard"
		"fieldName"			"vs_shutting_down"
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"f0"
		"tall"				"480"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"PaintBackgroundType"	"2"
	}
	
	"BackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"BackgroundImage"
		"xpos"			"c-150"
		"ypos"			"c-150"
		"zpos"			"0"
		"wide"			"300"
		"tall"			"90" [$ENGLISH]
		"tall"			"100" [!$ENGLISH]
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineGrey"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	"ModeTitle"
	{
		"ControlName"		"Label"
		"fieldName"			"ModeTitle"
		"xpos"				"c-130"
		"ypos"				"c-140"
		"zpos"				"1"
		"wide"				"260"
		"tall"				"25" [$ENGLISH]
		"tall"				"50" [!$ENGLISH]
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"#L4D_VS_Shutdown_Title"
		"textAlignment"		"west"
		"dulltext"			"0"
		"brighttext"		"0"
		"font"				"FrameTitle"
		"fgcolor_override"	"White"
		"wrap"				"0" [$ENGLISH]
		"wrap"				"1" [!$ENGLISH]
	}
	"SpawnModeOneText"
	{
		"ControlName"		"Label"
		"fieldName"			"SpawnModeOneText"
		"xpos"				"c-130"
		"ypos"				"c-115"	[$ENGLISH]
		"ypos"				"c-90" [!$ENGLISH]
		"zpos"				"1"
		"wide"				"260"
		"tall"				"50"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"#L4D_VS_Shutdown"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"0"
		"wrap"				"1"
		"font"				"DefaultMedium"
		"fgcolor_override"	"White"
	}
}
