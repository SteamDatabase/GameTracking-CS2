"Resource/UI/ScavengeModeEmbeddedScoreboard.res"
{
	"CenterBackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"CenterBackgroundImage"
		"xpos"			"3"
		"ypos"			"59"
		"wide"			"300"
		"tall"			"71"		
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
		"xpos"				"3"
		"ypos"				"59"
		"wide"				"300"
		"tall"				"71"
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
		"xpos"		"25"
		"ypos"		"56"
		"wide"		"200"
		"tall"		"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_Scavenge_Round_Current"
		"textAlignment"		"west"
		"font"		"MenuSubTitle"
		"fgcolor_override"	"MediumGray"
	}

	"RoundLimitLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"RoundLimitLabel"
		"xpos"		"85"
		"ypos"		"56"
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

//********************************************************
// Center scoreboard content
//********************************************************
	"ScoreBackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"ScoreBackgroundImage"
		"xpos"			"8"
		"ypos"			"70"
		"wide"			"290"
		"tall"			"60"
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
		"xpos"				"15"
		"ypos"				"82"
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
		"xpos"		"25"	[$WIN32]
		"ypos"		"82"	[$WIN32]
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
		"xpos"				"15"
		"ypos"				"104"
		"wide"				"16"
		"tall"				"16"
		"visible"			"1"
		"enabled"			"1"
		"scaleImage"		"1"
		"icon"				"icon_360_controller_1"
	}
	
	"EnemyTeamLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"EnemyTeamLabel"
		"xpos"		"25"	[$WIN32]
		"ypos"		"102"	[$WIN32]
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
		"xpos"			"140"
		"ypos"			"79"
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
		"xpos"			"161"
		"ypos"			"79"
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
		"xpos"			"182"
		"ypos"			"79"
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
		"xpos"			"203"
		"ypos"			"79"
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
		"xpos"			"224"
		"ypos"			"79"
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
		"ypos"			"78"
		"wide"			"24"
		"tall"			"44"		
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"15"
	}
}
