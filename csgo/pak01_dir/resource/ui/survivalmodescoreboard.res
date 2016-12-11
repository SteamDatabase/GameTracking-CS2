"Resource/UI/SurvivalModeScoreboard.res"		//the dialogue you see at the end of a survival round
{
	"TitleBackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"TitleBackgroundImage"
		"xpos"			"0"
		"ypos"			"-4"
		"wide"			"320"
		"tall"			"40"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"alpha"			"132"
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineRed"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	
	"FinalTimeLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"FinalTimeLabel"
		"xpos"		"20"
		"ypos"		"5"
		"wide"		"200"
		"tall"		"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_FinalTime"
		"textAlignment"		"west"
		"font"		"MenuTitle"
		"fgcolor_override"	"White"
	}
	
	"FinalTimeDigits"
	{
		"ControlName"		"Label"
		"fieldName"		"FinalTimeDigits"
		"xpos"		"150"
		"ypos"		"4"
		"wide"		"150"
		"tall"		"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"3:20.00"
		"textAlignment"		"east"
		"font"		"HudNumbers"
		"fgcolor_override"	"White"
	}

	"PlayersColumnLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"PlayersColumnLabel"
		"xpos"		"25"
		"ypos"		"30"
		"wide"		"200"
		"tall"		"30"
		"visible"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_Players"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"MediumGray"
	}	

	"TimeColumnLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"TimeColumnLabel"
		"xpos"		"160"
		"ypos"		"30"
		"wide"		"125"
		"tall"		"30"
		"visible"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_BestTime"
		"textAlignment"		"east"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"MediumGray"
	}	

	"Survivor1Entry"
	{
		"ControlName"		"CScoreboardEntry"
		"fieldName"		"Survivor1Entry"
		"xpos"		"5"
		"ypos"		"58"
		"wide"		"315"
		"tall"		"20"
		"visible"		"1"
	}	

	"Survivor2Entry"
	{
		"ControlName"		"CScoreboardEntry"
		"fieldName"		"Survivor2Entry"
		"xpos"		"5"
		"ypos"		"81"
		"wide"		"315"
		"tall"		"20"
		"visible"		"1"
	}	

	"Survivor3Entry"
	{
		"ControlName"		"CScoreboardEntry"
		"fieldName"		"Survivor3Entry"
		"xpos"		"5"
		"ypos"		"104"
		"wide"		"315"
		"tall"		"20"
		"visible"		"1"
	}	

	"Survivor4Entry"
	{
		"ControlName"		"CScoreboardEntry"
		"fieldName"		"Survivor4Entry"
		"xpos"		"5"
		"ypos"		"127"
		"wide"		"315"
		"tall"		"20"
		"visible"		"1"
	}	


//-----------------------------------------------------
// Infected Kills 
//-----------------------------------------------------

	"KillsHeader"
	{
		"ControlName"		"Label"
		"fieldName"		"KillsHeader"
		"xpos"		"340"
		"ypos"		"5"
		"wide"		"170"
		"tall"		"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_InfectedKilled"
		"textAlignment"		"west"
		"font"		"MenuTitle"
		"fgcolor_override"	"White"
	}

	"CommonKillsLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"CommonKillsLabel"
		"xpos"		"340"
		"ypos"		"25"
		"wide"		"150"
		"tall"		"20"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_Common"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"MediumGray"
	}
	
	"CommonKillsDigits"
	{
		"ControlName"		"Label"
		"fieldName"		"CommonKillsDigits"
		"xpos"		"466"
		"ypos"		"25"
		"wide"		"110"
		"tall"		"20"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"245"
		"textAlignment"		"west"
		"font"		"OuttroStatsCrawl"
	}

	"HunterKillsLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"HunterKillsLabel"
		"xpos"		"340"
		"ypos"		"43"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_Hunters"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"MediumGray"
	}	

	"HunterKillsDigits"
	{
		"ControlName"		"Label"
		"fieldName"		"HunterKillsDigits"
		"xpos"		"466"
		"ypos"		"43"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"17"
		"textAlignment"		"west"
		"font"		"OuttroStatsCrawl"
	}	

	"SmokerKillsLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"SmokerKillsLabel"
		"xpos"		"340"
		"ypos"		"61"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_Smokers"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"MediumGray"
	}	

	"SmokerKillsDigits"
	{
		"ControlName"		"Label"
		"fieldName"		"SmokerKillsDigits"
		"xpos"		"466"
		"ypos"		"61"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"19"
		"textAlignment"		"west"
		"font"		"OuttroStatsCrawl"
	}	

	"BoomerKillsLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"BoomerKillsLabel"
		"xpos"		"340"
		"ypos"		"79"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_Boomers"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"MediumGray"
	}	

	"BoomerKillsDigits"
	{
		"ControlName"		"Label"
		"fieldName"		"BoomerKillsDigits"
		"xpos"		"466"
		"ypos"		"79"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"6"
		"textAlignment"		"west"
		"font"		"OuttroStatsCrawl"
	}	

	"ChargersKillsLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"ChargerKillsLabel"
		"xpos"		"340"
		"ypos"		"97"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_Chargers"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"MediumGray"
	}	

	"ChargerKillsDigits"
	{
		"ControlName"		"Label"
		"fieldName"		"ChargerKillsDigits"
		"xpos"		"466"
		"ypos"		"97"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"6"
		"textAlignment"		"west"
		"font"		"OuttroStatsCrawl"
	}	

	"JockeyKillsLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"JockeyKillsLabel"
		"xpos"		"340"
		"ypos"		"115"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_Jockeys"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"MediumGray"
	}	

	"JockeyKillsDigits"
	{
		"ControlName"		"Label"
		"fieldName"		"JockeyKillsDigits"
		"xpos"		"466"
		"ypos"		"115"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"6"
		"textAlignment"		"west"
		"font"		"OuttroStatsCrawl"
	}	

	"SpitterKillsLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"SpitterKillsLabel"
		"xpos"		"340"
		"ypos"		"133"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_Spitters"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"MediumGray"
	}	

	"SpitterKillsDigits"
	{
		"ControlName"		"Label"
		"fieldName"		"SpitterKillsDigits"
		"xpos"		"466"
		"ypos"		"133"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"6"
		"textAlignment"		"west"
		"font"		"OuttroStatsCrawl"
	}	

	"TankKillsLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"TankKillsLabel"
		"xpos"		"340"
		"ypos"		"151"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"#L4D_SurvivalScoreboard_Tanks"
		"textAlignment"		"west"
		"font"		"PlayerDisplayName"
		"fgcolor_override"	"MediumGray"
	}	

	"TankKillsDigits"
	{
		"ControlName"		"Label"
		"fieldName"		"TankKillsDigits"
		"xpos"		"466"
		"ypos"		"151"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		"3"
		"textAlignment"		"west"
		"font"		"OuttroStatsCrawl"
	}	


//-----------------------------------------------------
// Xbox 360
//-----------------------------------------------------
	"GamerCardButton"	[$X360]
	{
		"ControlName"	"Label"
		"fieldName"		"GamerCardButton"
		"xpos"			"15"
		"ypos"			"155"
		"wide"			"24"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"PaintBackgroundType"	"0"
		"textAlignment"		"center"
		"dulltext"		"0"
		"brighttext"	"1"
		"font"			"GameUIButtons"
		"labelText"		"#GameUI_Icons_A_3DButton"
	}	
	
	"GamerCardLabel"	[$X360]
	{
		"ControlName"	"Label"
		"fieldName"		"GamerCardLabel"
		"xpos"			"40"
		"ypos"			"155"
		"wide"			"300"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_Scoreboard_View_GamerCard"
		"textAlignment"	"west"
		"dulltext"		"0"
		"brighttext"	"0"
		"font"			"DefaultLarge"
	}
}
