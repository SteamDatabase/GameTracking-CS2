"Resource/UI/NavErrorMessageBox.res"
{
	"message_box"
	{
		"ControlName"		"Frame"
		"fieldName"		"message_box"
		"xpos"			"c-100"
		"ypos"			"c-55"
		"wide"			"200"
		"tall"			"110"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"PaintBackgroundType"	"2"
	}

	"BackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"BackgroundImage"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"200"
		"tall"			"110"
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


	"title"
	{
		"ControlName"		"Label"
		"fieldName"		"title"
		"xpos"		"13"
		"ypos"		"11"
		"wide"		"200"
		"tall"		"24"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"NAV ERRORS"
		"textAlignment"		"north-west"
		"dulltext"		"0"
		"brighttext"		"0"
		"font"		"MenuTitle"
	}

	"text"
	{
		"ControlName"		"Label"
		"fieldName"		"text"
		"xpos"		"20"
		"ypos"		"36"
		"wide"		"170"
		"tall"		"40"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"0"
		"labelText"		"Map is unplayable!"
		"textAlignment"		"west"
		"dulltext"		"0"
		"brighttext"		"0"
		"Font"		"MenuTitle"
		"wrap"		"0"
		"fgcolor_override"	"255 32 0 255"
	}

	"ok"
	{
		"ControlName"		"RoundedButton"
		"fieldName"		"OK"
		"xpos"		"124"
		"ypos"		"80"
		"wide"		"64"
		"tall"		"18"
		"autoResize"		"1"
		"pinCorner"		"3"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"1"
		"labelText"		"#L4D_btn_continue"
		"textAlignment"		"center"
		"dulltext"		"0"
		"brighttext"		"0"
		"wrap"		"0"
		"Command"		"close"
		"Default"		"1"
		"selected"		"1"
	}
}
