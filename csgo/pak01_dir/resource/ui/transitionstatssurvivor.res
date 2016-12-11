"Resource/UI/TransitionStatsSurvivor.res"
{
	"transition_stats"
	{
		"ControlName"	"CTransitionStatsPanel"
		"fieldName"		"transition_stats"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"f0"
		"tall"			"480"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"		
		
		"statpanel_y_in_vsmode"		"205"
	}

	"HeaderBackground"
	{
		"ControlName"	"Panel"
		"fieldName"		"HeaderBackground"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"f0"
		"tall"			"60"	[$WIN32]
		"tall"			"80"	[$X360]
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"bgcolor_override"	"Black"
		"zpos"			"-2"
		"paintbackground"	"1"
	}
	
	"HeaderBorder"
	{
		"ControlName"	"Panel"
		"fieldName"		"HeaderBorder"
		"xpos"			"0"
		"ypos"			"60"	[$WIN32]
		"ypos"			"80"	[$X360]
		"wide"			"f0"
		"tall"			"1"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"bgcolor_override"	"100 100 100 255"
		"paintbackground"	"1"
	}

	"ClockIcon"
	{
		"ControlName"	"CIconPanel"
		"fieldName"		"ClockIcon"
		"icon"			"clock_1"
		"xpos"			"10"
		"ypos"			"15"
		"wide"			"24"
		"tall"			"24"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"scaleimage"	"1"
		"PaintBackgroundType"	"0"
		"usetitlesafe"	"1"
	}
	
	"WorkingAnim"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"WorkingAnim"
		"xpos"					"r45"
		"ypos"					"10"
		"zpos"					"5"
		"wide"					"40"
		"tall"					"40"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"usetitlesafe"			"1"
		"scaleImage"			"1"
		"image"					"common/l4d_spinner"
		"frame"					"0"
	}
	
	"LoadingText"
	{
		"ControlName"			"Label"
		"fieldName"				"LoadingText"
		"xpos"					"r250"
		"ypos"					"20"
		"zpos"					"5"
		"wide"					"200"
		"tall"					"20"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"Font"					"DefaultLarge"
		"labelText"				"#L4D360UI_Loading"
		"textAlignment"			"east"
		"usetitlesafe"			"1"
	}

	"CheckpointCleared"
	{
		"ControlName"			"Label"
		"fieldName"				"CheckpointCleared"
		"xpos"					"45"
		"ypos"					"15"
		"wide"					"300" [$ENGLISH]
		"wide"					"500" [!$ENGLISH]
		"tall"					"24"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"labelText"				"#L4D_ReportScreen_Title_Safe"
		"textAlignment"			"north-west"
		"dulltext"				"0"
		"brighttext"			"0"
		"fgcolor_override"		"White"
		"font"					"TransitionTitle"
		"usetitlesafe"			"1"
	}

	"NextMap"
	{
		"ControlName"			"Label"
		"fieldName"				"NextMap"
		"xpos"					"45"
		"ypos"					"40"
		"wide"					"300" [$ENGLISH]
		"wide"					"500" [!$ENGLISH]
		"tall"					"12"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"textAlignment"			"south-west"
		"dulltext"				"0"
		"brighttext"			"0"
		"wrap"					"0"
		"fgcolor_override"		"MediumGray"
		"font"					"Default"
		"usetitlesafe"			"1"
	}

	"SurvivorHighlightStatsPanel"
	{
		"ControlName"		"DontAutoCreate"
		"fieldName"			"SurvivorHighlightStatsPanel"
		"xpos"				"c-198"
		"ypos"				"122"		
		"wide"				"398"
		"tall"				"190"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"autoresize"		"0"
		"paintbackground"	"0"
	}
		
	"CVersusModeResults"
	{
		"ControlName"	"CVersusModeResults"
		"fieldName"		"VersusModeResults"
		"xpos"			"c-177"
		"ypos"			"95"
		"wide"			"354"		
		"tall"			"120"
		"visible"		"1"
		"enabled"		"1"
	}

	"FooterBackground"
	{
		"ControlName"		"Panel"
		"fieldName"			"FooterBackground"
		"xpos"				"0"
		"ypos"				"r65"	[$WIN32]
		"ypos"				"r90"	[$X360]
		"wide"				"f0"
		"tall"				"f0"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"bgcolor_override"	"Black"
		"zpos"				"-2"
	}
	
	"FooterBorder"
	{
		"ControlName"		"Panel"
		"fieldName"			"FooterBorder"
		"xpos"				"0"
		"ypos"				"r65"	[$WIN32]
		"ypos"				"r90"	[$X360]
		"wide"				"f0"
		"tall"				"1"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"bgcolor_override"	"100 100 100 255"
		"paintbackground"	"1"
	}

	"TipPanel"
	{
		"fieldName"			"TipPanel"
		"xpos"				"10"
		"ypos"				"r60"
		"wide"				"500" [$WIN32]
		"wide"				"400" [$X360]
		"tall"				"100"
		"visible"			"1"
		"enabled"			"1"
		"autoResize"		"1"
		"scaleimage"		"1"
		"zpos"				"50"
		"usetitlesafe"		"1"
	}
}
