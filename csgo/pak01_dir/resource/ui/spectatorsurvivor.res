"Resource/UI/SpectatorSurvivor.res"
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
	
	"death"
	{
		"ControlName"	"EditablePanel"
		"fieldName"		"death"
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
	
	"HeaderBackground"
	{
		"ControlName"	"Panel"
		"fieldName"		"HeaderBackground"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"f0"
		"tall"			"75"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"bgcolor_override"	"Black"
		"zpos"			"-2"
		"paintbackground"	"1"
	}

	"SkullIcon"
	{		
		"ControlName"		"CIconPanel"
		"fieldName"			"SkullIcon"
		"xpos"				"61"
		"ypos"				"34"
		"wide"				"24"
		"tall"				"24"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
		"icon"			    "icon_skull"
		"zpos"				"60"
		"scaleImage"	    "1"
	}

	"DeathMessage"
	{
		"ControlName"	"Label"
		"fieldName"		"DeathMessage"
		"xpos"		"89"
		"ypos"		"34"
		"wide"		"300"
		"tall"		"24"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_pz_spectator_title"
		"textAlignment"		"north-west"
		"dulltext"		"0"
		"brighttext"		"0"
		"fgcolor_override"	"White"
		"font"		"TransitionTitle"
	}

	"RescueMessage"
	{
		"ControlName"		"Label"
		"fieldName"		"RescueMessage"
		"xpos"		"100"
		"ypos"		"57"
		"wide"		"300"
		"tall"		"12"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%rescuemsg%"
		"textAlignment"		"north-west"
		"dulltext"		"0"
		"brighttext"		"0"
		"wrap"		"0"
		"fgcolor_override"	"DeepRed"
		"font"		"BodyText_medium"
	}
	
	"playerlabel"
	{
		"ControlName"	"Label"
		"fieldName"		"playerlabel"
		"xpos"			"r378"
		"ypos"			"r83"
		"wide"			"320"
		"tall"			"26"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"tabPosition"	"0"
		"textAlignment"	"east"
		"usetitlesafe"	"1"
	}

	"FooterBackground"
	{
		"ControlName"		"Panel"
		"fieldName"			"FooterBackground"
		"xpos"				"0"
		"ypos"				"r75"	[$WIN32]
		"ypos"				"r115"	[$X360]
		"wide"				"f0"
		"tall"				"75"	[$WIN32]
		"tall"				"115"	[$X360]
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"		
		"enabled"			"1"
		"tabPosition"		"0"
		"bgcolor_override"	"Black"
		"zpos"				"-2"
		
		"if_split_screen_active"
		{
			"visible"	"0"
		}
	}
	
	"InfoIcon"
	{
		"ControlName"		"CIconPanel"
		"fieldName"			"InfoIcon"
		"xpos"				"8"
		"ypos"				"r105"
		"zpos"				"1"
		"wide"				"24"
		"tall"				"24"
		"visible"			"0"			// REPOSITION ME AFTER E3
		"enabled"			"1"
		"tabPosition"		"0"
		"icon"			    "icon_tip"
		"zpos"				"60"
		"scaleImage"	    "1"
		"usetitlesafe"		"1"
		
		"if_split_screen_active"
		{
			"visible"	"0"
		}
	}
	
	"InfoIconBackground"
	{
		"ControlName"		"Panel"
		"fieldName"			"InfoIconBackground"
		"xpos"				"8"
		"ypos"				"r105"
		"zpos"				"0"
		"wide"				"324"
		"tall"				"45"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"tabPosition"		"0"
		"bgcolor_override"	"0 0 0 200"
		"usetitlesafe"		"1"
		
		"if_split_screen_active"
		{
			"visible"	"0"
		}
	}

	"TipText"
	{
		"ControlName"		"Label"
		"fieldName"			"TipText"
		"xpos"				"36"
		"ypos"				"r105"
		"zpos"				"1"
		"wide"				"300"
		"tall"				"45"
		"wrap"				"1"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"		// REPOSITION ME AFTER E3
		"enabled"			"1"
		"labelText"			"#L4D_SpecSurvivorTip"
		"textAlignment"		"north-west"
		"dulltext"			"0"
		"brighttext"		"1"
		"font"				"BodyText_small"
		"zpos"				"40"
		"usetitlesafe"		"1"
		
		"if_split_screen_active"
		{
			"visible"	"0"
		}
	}
}
