"Resource/UI/SurvivorTeamMenu.res"			//switching characters when you are already on the survivor team. Only works within spawn areas
{
	"class_survivor"
	{
		"ControlName"		"CSurvivorTeamMenu"
		"fieldName"		"class_survivor"
		"xpos"			"c-210"
		"ypos"			"c-110"
		"wide"			"420"
		"tall"			"220"
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
		"wide"			"420"
		"tall"			"220"
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
		"fieldName"		"ModeTitle"
		"xpos"		"13"
		"ypos"		"11"
		"wide"		"300"
		"tall"		"24"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_s_class_select_title"
		"textAlignment"		"north-west"
		"dulltext"		"0"
		"brighttext"		"0"
		"font"		"MenuTitle"
	}

	"SpawnModeLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"SpawnModeLabel"
		"xpos"		"13"
		"ypos"		"28"
		"wide"		"220"
		"tall"		"80"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_s_team_join_subtitle"
		"textAlignment"		"north-west"
		"dulltext"		"1"
		"brighttext"		"0"
		"wrap"		"1"
		"font"		"MenuSubTitle"
		"fgcolor"		"dialogueSubTitle"
	}

	"SurvivorPanel1"
	{
		"ControlName"		"CSurvivorTeamPlayerPanel"
		"fieldName"		"SurvivorPanel1"
		"xpos"			"13"
		"ypos"			"48"
		"wide"			"394"
		"tall"			"24"
		"zpos"			"-1"
		"autoResize"		"0"
		"pinCorner"		"2"
		"visible"		"1"
		"enabled"		"1"
		"navUp"			"Cancel"			[$X360]
		"navDown"		"SurvivorPanel2"	[$X360]
	}

	"SurvivorPanel2"
	{
		"ControlName"		"CSurvivorTeamPlayerPanel"
		"fieldName"		"SurvivorPanel2"
		"xpos"			"13"
		"ypos"			"74"
		"wide"			"394"
		"tall"			"24"
		"zpos"			"-1"
		"autoResize"		"0"
		"pinCorner"		"2"
		"visible"		"1"
		"enabled"		"1"
		"navUp"			"SurvivorPanel1"	[$X360]
		"navDown"		"SurvivorPanel3"	[$X360]
	}

	"SurvivorPanel3"
	{
		"ControlName"		"CSurvivorTeamPlayerPanel"
		"fieldName"		"SurvivorPanel3"
		"xpos"			"13"
		"ypos"			"100"
		"wide"			"394"
		"tall"			"24"
		"zpos"			"-1"
		"autoResize"		"0"
		"pinCorner"		"2"
		"visible"		"1"
		"enabled"		"1"
		"navUp"			"SurvivorPanel2"	[$X360]
		"navDown"		"SurvivorPanel4"	[$X360]
	}

	"SurvivorPanel4"
	{
		"ControlName"		"CSurvivorTeamPlayerPanel"
		"fieldName"		"SurvivorPanel4"
		"xpos"			"13"
		"ypos"			"126"
		"wide"			"394"
		"tall"			"24"
		"zpos"			"-1"
		"autoResize"		"0"
		"pinCorner"		"2"
		"visible"		"1"
		"enabled"		"1"
		"navUp"			"SurvivorPanel3"	[$X360]
		"navDown"		"Cancel"			[$X360]
	}

	"HorizBar"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"HorizBar"
		"xpos"			"13"
		"ypos"			"186"
		"wide"			"394"
		"tall"			"1"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"autoResize"		"0"
		"pinCorner"		"0"
		"image"			"../vgui/white"
		"drawcolor_override"	"64 64 64 255"
		"zpos"			"-1"
	}

	"Cancel"
	{
		"ControlName"		"RoundedButton"
		"fieldName"		"Cancel"
		"xpos"		"13"
		"ypos"		"190"
		"wide"		"64"
		"tall"		"18"
		"autoResize"		"1"
		"pinCorner"		"3"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"1"
		"labelText"		"#L4D_btn_cancel"
		"textAlignment"		"center"
		"dulltext"		"0"
		"brighttext"		"0"
		"wrap"		"0"
		"Command"		"close"
		"Default"		"1"
		"selected"		"1"
		"navUp"			"SurvivorPanel4"	[$X360]
		"navDown"		"SurvivorPanel1"	[$X360]
	}
}
