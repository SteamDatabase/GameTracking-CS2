"Resource/UI/ScavengeModeScoreboard.res"		//the dialogue you see at the end of a survival round
{
	"RoundInfoBackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"RoundInfoBackgroundImage"
		"xpos"			"20"
		"ypos"			"30"
		"wide"			"319"
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

	"RoundInfoBackgroundFill"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"RoundInfoBackgroundFill"
		"xpos"				"20"
		"ypos"				"30"
		"wide"				"319"
		"tall"				"26"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"fillcolor" 		"0 0 0 235"
		"zpos"				"-2"
	}

	"RoundInfoMessage"
	{
		"ControlName"		"Label"
		"fieldName"		"RoundInfoMessage"
		"xpos"		"35"
		"ypos"		"31"
		"wide"		"400"
		"tall"		"26"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_Scavenge_TeamFlip"
		"textAlignment"		"west"
		"font"		"MenuTitle"
		"fgcolor_override"	"White"
	}

	"CenterBackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"CenterBackgroundImage"
		"xpos"			"20"
		"ypos"			"57"
		"wide"			"319"
		"tall"			"75"		
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
		"xpos"				"20"
		"ypos"				"57"
		"wide"				"319"
		"tall"				"75"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"fillcolor" 		"0 0 0 235"
		"zpos"				"-2"
	}

	"RoundLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"RoundLabel"
		"xpos"		"35"
		"ypos"		"55"
		"wide"		"200"
		"tall"		"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_Scavenge_Round_Current"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"MediumGray"
	}

	"RoundLimitLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"RoundLimitLabel"
		"xpos"		"100"
		"ypos"		"55"
		"wide"		"200"
		"tall"		"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_Scavenge_RoundLimit"
		"textAlignment"		"east"
		"font"		"MenuSubTitle"
		"fgcolor_override"	"MediumGray"
	}

	"RoundTipBackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"RoundTipBackgroundImage"
		"xpos"			"20"
		"ypos"			"132"
		"wide"			"319"
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

	"RoundTipBackgroundFill"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"RoundTipBackgroundFill"
		"xpos"				"20"
		"ypos"				"132"
		"wide"				"319"
		"tall"				"26"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"fillcolor" 		"0 0 0 235"
		"zpos"				"-2"
	}

	"RoundTipMessage"
	{
		"ControlName"		"Label"
		"fieldName"		"RoundTipMessage"
		"xpos"		"20"
		"ypos"		"132"
		"wide"		"319"
		"tall"		"26"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_Scavenge_TeamFlip"
		"textAlignment"		"center"
		"font"		"MenuTitle"				[$ENGLISH]
		"font"		"BodyText_medium"		[!$ENGLISH]
		"fgcolor_override"	"White"
	}

//********************************************************
// Center scoreboard content
//********************************************************
	"ScoreBackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"ScoreBackgroundImage"
		"xpos"			"25"
		"ypos"			"70"
		"wide"			"310"
		"tall"			"62"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"alpha"			"212"
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineRed"
		"zpos"			"10"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}

	"XboxIconYourTeam"	[$X360]
	{
		"ControlName"		"CIconPanel"
		"fieldName"			"XboxIconYourTeam"
		"xpos"				"36"
		"ypos"				"84"
		"wide"				"16"
		"tall"				"16"
		"visible"			"1"
		"enabled"			"1"
		"scaleImage"		"1"
		"icon"				"icon_360_controller_1"
	}
	
	"YourTeamLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"YourTeamLabel"
		"xpos"		"42"	[$WIN32]
		"ypos"		"85"	[$WIN32]
		"xpos"		"2"		[$X360]
		"ypos"		"0"		[$X360]
		"wide"		"200"
		"tall"		"16"
		"visible"		"1"
		"labelText"		"#L4D_Scavenge_YourTeam"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"White"

		"pin_to_sibling"		"XboxIconYourTeam"		[$X360]
		"pin_corner_to_sibling"	"0"						[$X360]
		"pin_to_sibling_corner"	"1"						[$X360]
	}	

	"XboxIconEnemyTeam"	[$X360]
	{
		"ControlName"		"CIconPanel"
		"fieldName"			"XboxIconEnemyTeam"
		"xpos"				"36"
		"ypos"				"104"
		"wide"				"16"
		"tall"				"16"
		"visible"			"1"
		"enabled"			"1"
		"scaleImage"		"1"
		"icon"				"icon_360_controller_2"
	}
	
	"EnemyTeamLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"EnemyTeamLabel"
		"xpos"		"42"	[$WIN32]
		"ypos"		"105"	[$WIN32]
		"xpos"		"2"		[$X360]
		"ypos"		"0"		[$X360]
		"wide"		"200"
		"tall"		"16"
		"visible"		"1"
		"labelText"		"#L4D_Scavenge_Opponent"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"White"

		"pin_to_sibling"		"XboxIconEnemyTeam"		[$X360]
		"pin_corner_to_sibling"	"0"						[$X360]
		"pin_to_sibling_corner"	"1"						[$X360]
	}	

// **********  ROUND PANELS  ******************* 

	"Round1Panel"
	{
		"ControlName"	"CScavengeRoundPanel"
		"fieldName"		"Round1Panel"
		"xpos"			"170"
		"ypos"			"80"
		"wide"			"24"
		"tall"			"44"		
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"15"
	}
	"Round2Panel"
	{
		"ControlName"	"CScavengeRoundPanel"
		"fieldName"		"Round2Panel"
		"xpos"			"192"
		"ypos"			"80"
		"wide"			"24"
		"tall"			"44"		
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"15"
	}
	"Round3Panel"
	{
		"ControlName"	"CScavengeRoundPanel"
		"fieldName"		"Round3Panel"
		"xpos"			"213"
		"ypos"			"80"
		"wide"			"24"
		"tall"			"44"		
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"15"
	}
	"Round4Panel"
	{
		"ControlName"	"CScavengeRoundPanel"
		"fieldName"		"Round4Panel"
		"xpos"			"234"
		"ypos"			"80"
		"wide"			"24"
		"tall"			"44"		
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"15"
	}
	"Round5Panel"
	{
		"ControlName"	"CScavengeRoundPanel"
		"fieldName"		"Round5Panel"
		"xpos"			"255"
		"ypos"			"80"
		"wide"			"24"
		"tall"			"44"		
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"15"
	}

	"FinalScorePanel"
	{
		"ControlName"	"CScavengeRoundPanel"
		"fieldName"		"FinalScorePanel"
		"xpos"			"275"
		"ypos"			"80"
		"wide"			"24"
		"tall"			"44"		
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"15"
	}
	
	"SplatterTopLeft"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"SplatterTopLeft"
		"xpos"				"0"
		"ypos"				"10"
		"wide"				"100"
		"tall"				"60"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"../vgui/hud/splatter1"
		"drawColor"			"64 64 64 255"
		"zpos"				"-3"
	}
	
	"SplatterBottomLeft"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"SplatterBottomLeft"
		"xpos"				"-5"
		"ypos"				"105"
		"wide"				"80"
		"tall"				"80"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"../vgui/hud/splatter3"
		"drawColor"			"64 64 64 255"
		"zpos"				"-3"
	}
	
	"SplatterTopRight"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"SplatterTopRight"
		"xpos"				"276"
		"ypos"				"-6"
		"wide"				"80"
		"tall"				"80"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"../vgui/hud/splatter_corner_upper_right"
		"drawColor"			"64 64 64 255"
		"zpos"				"-3"
	}
		
	"SplatterBottom"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"SplatterBottom"
		"xpos"				"193"
		"ypos"				"158"
		"wide"				"110"
		"tall"				"30"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"../vgui/hud/splatter_horizontal_bottom"
		"drawColor"			"64 64 64 255"
		"zpos"				"-3"
	}
}
