"panels"
{
	"Armed"
	{
		"ControlName"	"Panel"
		"fieldName"		"Armed"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"64"
		"tall"			"18"
		"visible"		"0"
		"enabled"		"1"
		"zpos"			"-1"
		"bgcolor_override"	"0 255 255 128"
	}
	"Depressed"
	{
		"ControlName"	"Panel"
		"fieldName"		"Depressed"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"64"
		"tall"			"18"
		"visible"		"0"
		"enabled"		"1"
		"zpos"			"-1"
		"bgcolor_override"	"0 255 0 128"
	}
	"Normal"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"Normal"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"f0"
		"tall"			"f0"
		"visible"		"0"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineGrey"
		"zpos"			"-1"
		"proportionalToParent"	"1"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
}
