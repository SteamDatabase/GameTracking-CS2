"Resource/UI/SurvivorTeamMenuAvailable.res"			//layout for human survivor in team select screens
{
	"Head"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"Head"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"24"
		"tall"			"24"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"autoResize"		"0"
		"pinCorner"		"0"
	}

	"Background" [$X360]
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"Background"
		"xpos"			"26"
		"ypos"			"0"
		"wide"			"368"
		"tall"			"24"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"autoResize"		"0"
		"pinCorner"		"0"
		"image"			"../vgui/white"
		"drawcolor_override"	"38 38 38 100"
		"zpos"			"-1"
	}
	
	"Avatar"
	{
		"ControlName"	"CAvatarImagePanel"
		"fieldName"		"Avatar"
		"xpos"			"28"
		"ypos"			"1"
		"wide"			"22"
		"tall"			"22"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"
		"autoResize"		"0"
		"pinCorner"		"0"
		"drawcolor_override"	"128 128 128 255"
	}

	"Name"
	{
		"ControlName"	"Label"
		"fieldName"		"Name"
		"xpos"			"52"
		"ypos"			"0"
		"wide"			"70"
		"tall"			"12"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_s_team_join_state_inactive"
		"textAlignment"	"west"
		"font"			"PlayerDisplayName"
		"dulltext"		"1"
	}

	"TimePlayed"
	{
		"ControlName"	"Label"
		"fieldName"		"TimePlayed"
		"xpos"			"52"
		"ypos"			"10"
		"wide"			"70"
		"tall"			"12"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"0"
		"textAlignment"	"west"
		"font"			"DefaultVerySmall"
		"dulltext"		"1"
	}
}
