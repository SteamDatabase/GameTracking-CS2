"Resource/UI/ScavengeTieBreakerPanel.res"
{
	"TieBreakerPanel"
	{
		"ControlName"		"TieBreakerPanel"
		"fieldName"			"tiebreaker"
		"xpos"				"0"
		"ypos"				"0"
		"wide"				"320"
		"tall"				"150"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"tabPosition"		"0"
		"padding"			"4"
		"zpos"				"50"
	}
	
	"HeaderBackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"HeaderBackgroundImage"
		"xpos"			"40"
		"ypos"			"45"
		"wide"			"280"
		"tall"			"26"		
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack50_outlineGrey"
		"drawcolor"		"255 64 64 255"
		"src_corner_height"		"16"			// pixels inside the image
		"src_corner_width"		"16"
		"draw_corner_width"		"3"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"3"	
	}

	"HeaderBackgroundFill"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"HeaderBackgroundFill"
		"xpos"				"40"
		"ypos"				"45"
		"wide"				"280"
		"tall"				"26"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"fillcolor" 		"0 0 0 255"
		"zpos"				"-2"
	}

	"RoundInfoMessage"
	{
		"ControlName"		"Label"
		"fieldName"		"RoundInfoMessage"
		"xpos"		"55"
		"ypos"		"45"
		"wide"		"260"
		"tall"		"26"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_Scavenge_TieBreaker_Title"
		"textAlignment"		"west"
		"font"		"MenuTitle"
		"fgcolor_override"	"White"
	}
	
	"CenterBackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"CenterBackgroundImage"
		"xpos"			"40"
		"ypos"			"70"
		"wide"			"280"
		"tall"			"65"		
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack50_outlineGrey"
		"drawcolor"		"255 64 64 255"
		"src_corner_height"		"16"			// pixels inside the image
		"src_corner_width"		"16"
		"draw_corner_width"		"3"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"3"	
	}
	"CenterBackgroundFill"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"CenterBackgroundFill"
		"xpos"				"40"
		"ypos"				"70"
		"wide"				"280"
		"tall"				"65"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"fillcolor" 		"0 0 0 255"
		"zpos"				"-2"
	}
		
	"TieBreakerMethodLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"TieBreakerMethodLabel"
		"xpos"				"40"
		"ypos"				"70"
		"wide"				"280"
		"tall"				"20"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			""
		"textAlignment"		"center"
		"font"				"PlayerDisplayName"
	}
	
	"YourTeamLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"YourTeamLabel"
		"xpos"		"80"
		"ypos"		"85"
		"wide"		"200"
		"tall"		"30"
		"visible"		"1"
		"labelText"		"#L4D_Scavenge_YourTeam"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"White"
	}	

	"EnemyTeamLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"EnemyTeamLabel"
		"xpos"		"80"
		"ypos"		"105"
		"wide"		"200"
		"tall"		"30"
		"visible"		"1"
		"labelText"		"#L4D_Scavenge_Opponent"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"White"
	}	

	"YourTeamTime"
	{
		"ControlName"		"Label"
		"fieldName"		"YourTeamTime"
		"xpos"		"200"
		"ypos"		"85"
		"wide"		"100"
		"tall"		"30"
		"visible"		"1"
		"labelText"		"00:00.00"
		"textAlignment"		"west"
		"font"		"MenuTitle"
		"fgcolor_override"	"White"
	}	
	
	"EnemyTeamTime"
	{
		"ControlName"		"Label"
		"fieldName"		"EnemyTeamTime"
		"xpos"		"200"
		"ypos"		"105"
		"wide"		"100"
		"tall"		"30"
		"visible"		"1"
		"labelText"		"00:00.00"
		"textAlignment"		"west"
		"font"		"MenuTitle"
		"fgcolor_override"	"White"
	}	
}