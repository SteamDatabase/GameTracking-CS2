"Resource/UI/UpgradeMenu.res"
{
	"upgrade"
	{
		"ControlName"		"CUpgradeMenu"
		"fieldName"		"upgrade"
		"xpos"			"c-134"
		"ypos"			"c-92"
		"wide"			"268"
		"tall"			"134"
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
		"wide"			"268"
		"tall"			"134"
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

	"Title"
	{
		"ControlName"		"Label"
		"fieldName"		"Title"
		"xpos"		"12"
		"ypos"		"10"
		"wide"		"256"
		"tall"		"24"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_Upgrade_Title"
		"textAlignment"		"west"
		"dulltext"		"0"
		"brighttext"		"0"
		"font"		"MenuTitle"
	}

	"UpgradeIcon"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"UpgradeIcon"
		"xpos"			"10"
		"ypos"			"30"
		"wide"			"32"
		"tall"			"32"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineGrey"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"4"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"4"	
	}

	"UpgradeName"
	{
		"ControlName"		"Label"
		"fieldName"		"UpgradeName"
		"xpos"		"52"
		"ypos"		"32"
		"wide"		"150"
		"tall"		"12"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		""
		"textAlignment"		"west"
		"dulltext"		"0"
		"brighttext"		"0"
		"wrap"		"0"
		"fgcolor_override"	"192 0 0 255"
	}
	"UpgradeDuration"
	{
		"ControlName"		"Label"
		"fieldName"		"UpgradeDuration"
		"xpos"		"52"
		"ypos"		"44"
		"wide"		"150"
		"tall"		"12"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		""
		"textAlignment"		"west"
		"dulltext"		"0"
		"brighttext"		"0"
		"wrap"		"0"
		"fgcolor_override"	"192 192 192 255"
	}

	"UpgradeDescription"
	{
		"ControlName"		"Label"
		"fieldName"		"UpgradeDescription"
		"xpos"		"12"
		"ypos"		"64"
		"wide"		"245"
		"tall"		"40"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		""
		"textAlignment"		"north-west"
		"dulltext"		"1"
		"brighttext"		"0"
		"wrap"		"1"
		"fgcolor_override"	"192 192 192 255"
	}

	"OK"
	{
		"ControlName"		"RoundedButton"
		"fieldName"		"OK"
		"xpos"		"192"
		"ypos"		"105"
		"wide"		"64"
		"tall"		"18"
		"autoResize"		"1"
		"pinCorner"		"3"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"1"
		"labelText"		"#L4D_btn_ok"
		"textAlignment"		"center"
		"dulltext"		"0"
		"brighttext"		"0"
		"wrap"		"0"
		"Command"		"close"
		"Default"		"1"
		"selected"		"1"
	}
}
