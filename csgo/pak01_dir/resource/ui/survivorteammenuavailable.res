"Resource/UI/SurvivorTeamMenuAvailable.res"			//available slot on the survivor team
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

	"Background"
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
		"drawcolor_override"	"38 38 38 255"
		"zpos"			"-1"
	}

	"Name"
	{
		"ControlName"	"Label"
		"fieldName"		"Name"
		"xpos"			"28"
		"ypos"			"0"
		"wide"			"70"
		"tall"			"12"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_s_team_join_state_inactive"
		"textAlignment"	"west"
		"font"			"PlayerDisplayName"
	}

	"Health"
	{
		"ControlName"	"HealthPanel"
		"fieldName"		"Health"
		"xpos"			"28"
		"ypos"			"14"
		"wide"			"96"
		"tall"			"7"
		"visible"		"1"
		"enabled"		"1"
		"zpos"			"1"
	}

	"Select"
	{
		"ControlName"		"RoundedButton"
		"fieldName"		"Select"
		"xpos"			"324"
		"ypos"			"3"
		"wide"			"64"
		"tall"			"18"
		"autoResize"		"0"
		"pinCorner"		"2"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"		"3"
		"labelText"		"#L4D_btn_select"
		"textAlignment"		"center"
		"dulltext"		"0"
		"brighttext"		"0"
		"command"		"select"
	}
}
