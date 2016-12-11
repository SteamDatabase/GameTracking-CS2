"Resource/UI/SurvivalModeScoreboardEntry.res"
{
	"SurvivorAvatar"
	{
		"ControlName"	"CAvatarImagePanel"
		"fieldName"		"SurvivorAvatar"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"16"
		"tall"			"16"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"autoResize"		"0"
		"pinCorner"		"0"
	}

	"SurvivorName"
	{
		"ControlName"		"Label"
		"fieldName"		"SurvivorName"
		"xpos"		"20"
		"ypos"		"0"
		"wide"		"200"
		"tall"		"20"
		"visible"		"1"
		"labelText"		""
		"textAlignment"		"west"
		"font"		"PlayerDisplayHealth"
		"fgcolor_override"	"MediumGray"
		"noshortcutsyntax" "1"
	}	

	"SurvivorTime"
	{
		"ControlName"		"Label"
		"fieldName"		"SurvivorTime"
		"xpos"		"160"
		"ypos"		"1"
		"wide"		"125"
		"tall"		"20"
		"visible"		"1"
		"labelText"		""
		"textAlignment"		"east"
		"font"		"OuttroStatsCrawl"
		"fgcolor_override"	"MediumGray"
	}	

	"SurvivorMedal"
	{
		"ControlName"	"CIconPanel"
		"fieldName"		"SurvivorMedal"
		"xpos"			"286"
		"ypos"			"1" [$X360]
		"ypos"			"2" [$WIN32]
		"wide"			"18"
		"tall"			"18"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"icon"			"icon_bronze_medal_small"
	}
}
