"Resource/UI/AchievementListItem.res"
{
	"AchievementListItem"
	{
		"ControlName"		"Frame"
		"fieldName"		"AchievementListItem"
		"tall"			"40"	[$X360]
		"tall"			"48"	[$WIN32]
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"usetitlesafe"	"1"
		
		"DetailsExtraHeight"	"14"
		"DetailsRowHeight"	"16"
	}

	"LblName"
	{
		"ControlName"	"Label"
		"fieldName"		"LblName"
		"xpos"			"42"
		"ypos"			"2"  [$WIN32]
		"ypos"			"0"  [$X360]
		"wide"			"265"
		"tall"			"24" [$WIN32]
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"textAlignment"	"north-west"
		"Font"			"DefaultBold" [$WIN32]
		"font_hidef"	"DefaultBold" [$X360]
		"font_lodef"	"DefaultVerySmall" [$X360]
	}

	"LblProgress"
	{
		"ControlName"	"Label"
		"fieldName"		"LblProgress"
		"xpos"			"230"
		"ypos"			"0"
		"wide"			"100"
		"tall"			"10"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"tabPosition"	"0"
	}

	"DivTitleDivider"
	{
		"ControlName"	"Label"
		"fieldName"		"DivTitleDivider"
		"xpos"			"2"
		"ypos"			"21"
		"autoResize"	"1"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"tabPosition"	"0"
	}

	"ImgAchievementIcon"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"ImgAchievementIcon"
		"xpos"				"2"
		"ypos"				"2"
		"wide"				"36"
		"tall"				"36"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"tabPosition"		"0"
	}

	"LblHowTo"
	{
		"ControlName"	"Label"
		"fieldName"		"LblHowTo"
		"xpos"			"42"
		"ypos"			"16"	[$WIN32]
		"ypos_hidef"	"14"	[$X360]
		"ypos_lodef"	"12"	[$X360]
		"wide"			"394"	[$X360]
		"wide"			"386"	[$WIN32]
		"tall"			"25"	[$X360]
		"tall"			"28"	[$WIN32]
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"wrap"			"1"
		"textAlignment"	"north-west"
		"font"			"DefaultMedium" [$WIN32]
		"font"			"DefaultVerySmall" [$X360]
	}

	"PrgProgress"
	{
		"ControlName"	"ProgressBar"
		"fieldName"		"PrgProgress"
		"xpos"			"325"
		"ypos"			"4"	[$WIN32]
		"ypos_hidef"	"4" [$X360]
		"ypos_lodef"	"1" [$X360]
		"wide"			"100"
		"tall"			"11"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
	}

	"LblCurrProgress"
	{
		"ControlName"	"Label"
		"fieldName"		"LblCurrProgress"
		"xpos"			"220"
		"ypos_hidef"	"3"		[$X360]
		"ypos_lodef"	"0"		[$X360]
		"wide"			"100"
		"tall"			"24"	[$WIN32]
		"ypos"			"2"		[$WIN32]
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"textAlignment"	"north-east"
		"font"			"Default" [$WIN32]
	}

	"LblGamerScore"
	{
		"ControlName"	"Label"
		"fieldName"		"LblName"
		"xpos"			"430"
		"ypos"			"0"
		"wide"			"50"
		"tall"			"24" [$WIN32]
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"tabPosition"	"0"
		"textAlignment"	"north-east"
		"font"			"DefaultLarge"
	}
	
	"BtnDetails" [$WIN32]
	{
		"ControlName"	"Button"
		"fieldName"		"BtnDetails"
		"xpos"			"2"
		"ypos"			"45"
		"zpos"			"2"
		"wide"			"10"
		"tall"			"10"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"tabPosition"	"0"
		"labelText"		"+"
		"command"		"toggle_details"
		"font"			"DefaultVerySmall"
		"textAlignment"	"south"	
	}
	
	"LblDetails" [$WIN32]
	{
		"ControlName"	"Label"
		"fieldName"		"LblDetails"
		"xpos"			"16"
		"ypos"			"43"
		"zpos"			"2"
		"wide"			"100"
		"tall"			"14"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"1"
		"tabPosition"	"0"
		"textAlignment"	"west"
		"font"			"DefaultVerySmall"
	}
		
	"ComponentTemplateLeft"
	{
		"ControlName"	"Label"
		"fieldName"		"ComponentTemplateLeft"
		"xpos"			"65"
		"ypos"			"55"
		"wide"			"265"
		"tall"			"16"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"0"
		"tabPosition"	"0"
		"Font"			"DefaultVerySmall"
		"textAlignment"	"north-west"	
	}
	
	"ComponentTemplateRight"
	{
		"ControlName"	"Label"
		"fieldName"		"ComponentTemplateRight"
		"xpos"			"245"
		"ypos"			"55"
		"wide"			"265"
		"tall"			"16"
		"autoResize"	"0"
		"pinCorner"		"0"
		"visible"		"0"
		"enabled"		"0"
		"tabPosition"	"0"
		"Font"			"DefaultVerySmall"
		"textAlignment"	"north-west"	
	}
	
	"CheckmarkTemplateLeft"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"CheckmarkTemplateLeft"
		"xpos"				"50"
		"ypos"				"55"
		"wide"				"12"
		"tall"				"12"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"tabPosition"		"0"
		"image"				"hud/vote_yes"
		"scaleImage"		"1"
	}	
	
	"CheckmarkTemplateRight"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"CheckmarkTemplateRight"
		"xpos"				"230"
		"ypos"				"55"
		"wide"				"12"
		"tall"				"12"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"tabPosition"		"0"
		"image"				"hud/vote_yes"
		"scaleImage"		"1"
	}	
}