"Resource/UI/SpectatorGUI.res"
{
	"specgui"
	{
		"ControlName"	"Frame"
		"fieldName"		"specgui"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"f0"
		"tall"			"480"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
	}

	"BackgroundImage"
	{
		"ControlName"	"ImagePanel"
		"fieldName"		"BackgroundImage"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"f0"
		"tall"			"75"	[$WIN32]
		"tall"			"160"	[$X360]
		"visible"		"1"
		"enabled"		"1"
		"autoResize"	"3"
		"pinCorner"		"0"
		"scaleImage"	"1"
		"image"			"../vgui/ghost_title_bg"
		"zpos"			"-2"
		
		"if_overlap_scavenge_can"
		{
			"tall"		"225"	[$WIN32]
			"tall"		"230"	[$X360]
		}
		
		"if_overlap_scavenge_timer"
		{
			"tall"		"255"	[$WIN32]
			"tall"		"240"	[$X360]
		}
		
		"if_split_screen_bottom"
		{
			"tall"		"120"	[$X360]
		}
	}

	"SpawnModeLabel"
	{
		"ControlName"		"Label"
		"fieldName"		"SpawnModeLabel"
		"xpos"		"c-150"
		"ypos"		"4"
		"wide"		"300"
		"tall"		"24"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_pz_spectator_title"
		"textAlignment"		"north"
		"dulltext"		"0"
		"brighttext"		"0"
		"font"		"MenuTitle"
		"fgcolor_override"	"128 128 128 255"
		"usetitlesafe"	"2"
		
		"if_overlap_scavenge_can"
		{
			"ypos"		"68"	[$WIN32]
			"ypos"		"34"	[$X360]
		}
		
		"if_overlap_scavenge_timer"
		{
			"ypos"		"83"	[$WIN32]
			"ypos"		"39"	[$X360]
		}
		
		"if_split_screen_bottom"
		{
			"ypos"		"-13"	[$X360]
		}
	}

	"InfectedState"
	{
		"ControlName"		"Label"
		"fieldName"		"InfectedState"
		"xpos"		"c-150"
		"ypos"		"14"
		"wide"		"300"
		"tall"		"24"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		""
		"textAlignment"		"center"
		"dulltext"		"0"
		"brighttext"		"0"
		"font"		"default"
		"usetitlesafe"	"2"
		
		"if_overlap_scavenge_can"
		{
			"ypos"		"78"	[$WIN32]
			"ypos"		"44"	[$X360]
		}
		
		"if_overlap_scavenge_timer"
		{
			"ypos"		"93"	[$WIN32]
			"ypos"		"49"	[$X360]
		}
		
		"if_split_screen_bottom"
		{
			"ypos"		"-3"	[$X360]
		}
	}

	"death"
	{
		"ControlName"	"DeathPanel"
		"fieldName"		"death"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"f0"
		"tall"			"480"
		"visible"		"0"
		"enabled"		"1"
		"autoResize"	"3"
		"pinCorner"		"0"
		"zpos"			"1"
		"usetitlesafe"	"1"
	}

	"playerlabel"
	{
		"ControlName"	"Label"
		"fieldName"		"playerlabel"
		"xpos"			"r378"
		"ypos"			"r63"
		"wide"			"320"
		"tall"			"26"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"tabPosition"	"0"
		"textAlignment"	"south-east"
		
		"if_split_screen_vertical"
 		{
	 		"ypos"		"r100"
  		}
	}

	"Seconds_1"
	{
		"ControlName"		"Label"
		"fieldName"		"Seconds_1"
		"xpos"		"46"
		"ypos"		"240"
		"wide"		"220"
		"tall"		"12"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"labelText"		"#L4D_s_team_ready_seconds_1"
		"textAlignment"		"west"
		"dulltext"		"0"
		"brighttext"		"0"
		"wrap"		"0"
		"font"		"MenuSubTitle"
	}

	"Seconds_2"
	{
		"ControlName"		"Label"
		"fieldName"		"Seconds_2"
		"xpos"		"46"
		"ypos"		"252"
		"wide"		"220"
		"tall"		"12"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"labelText"		"#L4D_s_team_ready_seconds_2"
		"textAlignment"		"west"
		"dulltext"		"0"
		"brighttext"		"0"
		"wrap"		"0"
		"font"		"MenuSubTitle"
	}

	"Countdown"
	{
		"ControlName"		"Label"
		"fieldName"		"Countdown"
		"xpos"		"10"
		"ypos"		"240"
		"wide"		"32"
		"tall"		"24"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"labelText"		""
		"textAlignment"		"center"
		"dulltext"		"0"
		"brighttext"		"0"
		"bgcolor_override"	"255 255 255 255"
		"fgcolor_override"	"0 0 0 255"
		"font"		"MenuTitle"
	}
}
