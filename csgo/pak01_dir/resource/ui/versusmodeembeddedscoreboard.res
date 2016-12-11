"Resource/UI/VersusModeEmbeddedScoreboard.res"
{
	"XboxIconYourTeam"	[$X360]
	{
		"ControlName"		"CIconPanel"
		"fieldName"			"XboxIconYourTeam"
		"xpos"				"16"
		"ypos"				"32"
		"zpos"				"3"
		"wide"				"0"
		"tall"				"16"
		"visible"			"1"
		"enabled"			"1"
		"scaleImage"		"1"
		"icon"				"icon_360_controller_1"
	}
	
	"TeamYours"
	{
		"ControlName"		"Label"
		"fieldName"		"TeamYours"
		"xpos"		"2"		[$X360]
		"ypos"		"2"		[$X360]
		"xpos"		"16"	[$WIN32]
		"ypos"		"30"	[$WIN32]
		"wide"		"125"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_VSScoreboard_YourTeam"
		"textAlignment"		"west"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle_ss"
		"fgcolor_override"	"White"
		
		"pin_to_sibling"		"XboxIconYourTeam"		[$X360]
		"pin_corner_to_sibling"	"0"						[$X360]
		"pin_to_sibling_corner"	"1"						[$X360]
	}
	
	"TotalScoreYourTeam"	//"Total Score:"
	{
		"ControlName"		"Label"
		"fieldName"		"TotalScoreYourTeam"
		"xpos"		"16"
		"ypos"		"45"
		"wide"		"125"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_vs_TotalScore_Embedded"
		"textAlignment"		"west"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle_ss"
		"fgcolor_override"	"White"
	}
	
	"XboxIconEnemyTeam"	[$X360]
	{
		"ControlName"		"CIconPanel"
		"fieldName"			"XboxIconEnemyTeam"
		"xpos"				"169"
		"ypos"				"32"
		"zpos"				"3"
		"wide"				"0"
		"tall"				"16"
		"visible"			"1"
		"enabled"			"1"
		"scaleImage"		"1"
		"icon"				"icon_360_controller_2"
	}

	"TeamEnemy"
	{
		"ControlName"		"Label"
		"fieldName"		"TeamEnemy"
		"xpos"		"2"				[$X360]	
		"ypos"		"2"				[$X360]
		"xpos"		"169"			[$WIN32]
		"ypos"		"30"			[$WIN32]
		"wide"		"125"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_VSScoreboard_EnemyTeam"
		"textAlignment"		"west"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle_ss"
		"fgcolor_override"	"White"
		
		"pin_to_sibling"		"XboxIconEnemyTeam"		[$X360]
		"pin_corner_to_sibling"	"0"						[$X360]
		"pin_to_sibling_corner"	"1"						[$X360]
	}
	
	"TotalScoreEnemyTeam"	// "Total Score:"
	{
		"ControlName"		"Label"
		"fieldName"		"TotalScoreEnemyTeam"
		"xpos"		"169"
		"ypos"		"45"
		"wide"		"125"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_vs_TotalScore_Embedded"
		"textAlignment"		"west"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle_ss"
		"fgcolor_override"	"White"
	}

	"TeamYourScoreSurvivors"
	{
		"ControlName"		"Label"
		"fieldName"		"TeamYourScoreSurvivors"
		"xpos"		"17"
		"ypos"		"44"
		"wide"		"125"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%YourSurvivor%"
		"textAlignment"		"east"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle"
		"fgcolor_override"	"White"
	}

	"TeamEnemyScoreSurvivors"
	{
		"ControlName"		"Label"
		"fieldName"		"TeamEnemyScoreSurvivors"
		"xpos"		"173"
		"ypos"		"45"
		"wide"		"125"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%EnemySurvivor%"
		"textAlignment"		"east"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle"
		"fgcolor_override"	"White"
	}
	
	"YourTeamBackground"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"YourTeamBackground"
		"xpos"		"3"
		"ypos"		"25"
		"wide"		"150"
		"tall"		"45"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	
	"EnemyTeamBackground"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"EnemyTeamBackground"
		"xpos"		"158"
		"ypos"		"25"
		"wide"		"150"
		"tall"		"45"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	
	// progress background box
	"BackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"BackgroundImage"
		"xpos"		"3"
		"ypos"		"70"
		"wide"		"305"	
		"tall"		"68"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack"
		"zpos"			"-1"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
		
	"CompletionLabel"
	{
		"ControlName"	"Label"
		"fieldName"		"CompletionLabel"
		"xpos"			"65"
		"ypos"			"72"
		"wide"			"320"
		"tall"			"20"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_VSScoreboard_Completion"
		"textAlignment"	"south-west"
		"dulltext"		"1"
		"brighttext"	"0"
		"fgcolor_override"	"White"
		"font"				"BodyText_medium"
		"auto_wide_tocontents"	"1"
	}	
	
	"CompletionAmountLabel"
	{
		"ControlName"	"Label"
		"fieldName"		"CompletionAmountLabel"
		"xpos"			"200"
		"ypos"			"74"
		"wide"			"100"
		"tall"			"20"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%completion%"
		"textAlignment"	"south-east"
		"dulltext"		"1"
		"brighttext"	"0"
		"fgcolor_override"	"White"
		"font"				"InstructorTitle"
	}
	
	"TeamImage"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"TeamImage"
		"xpos"				"10"
		"ypos"				"78"
		"wide"				"50"
		"tall"				"50"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"select_survivors"
		"drawColor"			"180 180 180 255"
		"zpos"				"0"
	}
	
	"CompletionProgressBar"
	{
		"ControlName"	"CVersusModeLevelProgressBar"
		"fieldName"		"CompletionProgressBar"
		"xpos"			"55"
		"ypos"			"88"
		"wide"			"255"
		"tall"			"60"
		"zpos"			"1"
		"visible"		"1"
		"enabled"		"1"	
		
		"bar_x"			"10"
		"bar_y"			"10"
		"bar_w"			"235"
		"bar_h"			"4"
		"bar_gap"		"3"
		
		"skull_size"	"14"
		"skull_y"		"-5"
		
		"bar_color"					"VersusBrown"
		"bar_localplayer_color"		"VersusSelected"
		"bar_bgcolor"				"VersusDarkGrey"
	}
}
