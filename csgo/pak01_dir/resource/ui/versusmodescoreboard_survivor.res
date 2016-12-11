"Resource/UI/VersusModeScoreboard_Survivor.res"
{
	"TeamImage"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"TeamImage"
		"xpos"				"6"
		"ypos"				"6"
		"wide"				"50"
		"tall"				"50"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"image"				"select_survivors"
		"drawColor"			"180 180 180 64"	[!$ENGLISH]
		"drawColor"			"180 180 180 255"	[$ENGLISH]
		"zpos"				"0"
	}
	
	//===============================
	// Score categories
	
	"Category_Completion"
	{
		"ControlName"		"Label"
		"fieldName"			"Category_Completion"
		"xpos"				"5"
		"ypos"				"32"
		"wide"				"180"
		"tall"				"20"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"#L4D_VSScoreboard_Completion"
		"textAlignment"		"east"
		"dulltext"			"1"
		"brighttext"		"0"
		"font"				"BodyText_medium"
		"fgcolor_override"	"MediumGray"
	}
	
	"Category_Completion_Score"
	{
		"ControlName"		"Label"
		"fieldName"			"Category_Completion_Score"
		"xpos"				"190"
		"ypos"				"32"
		"wide"				"60"
		"tall"				"20"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"0"
		"textAlignment"		"west"
		"dulltext"			"1"
		"brighttext"		"0"
		"font"				"BodyText_medium"
		"fgcolor_override"	"MediumGray"
	}
	
	"Category_SurvivalBonus"
	{
		"ControlName"		"Label"
		"fieldName"			"Category_SurvivalBonus"
		"xpos"				"5"
		"ypos"				"47"
		"wide"				"180"
		"tall"				"20"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"0"
		"labelText"			"#L4D_VSScoreboard_SurvivalBonus"
		"textAlignment"		"east"
		"dulltext"			"1"
		"brighttext"		"0"
		"font"				"BodyText_medium"
		"fgcolor_override"	"MediumGray"
	}
	
	"Category_SurvivalBonus_Score"
	{
		"ControlName"		"Label"
		"fieldName"			"Category_SurvivalBonus_Score"
		"xpos"				"190"
		"ypos"				"47"
		"wide"				"68"
		"tall"				"20"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"labelText"			"0"
		"textAlignment"		"west"
		"dulltext"			"1"
		"brighttext"		"0"
		"font"				"BodyText_medium"
		"fgcolor_override"	"MediumGray"
	}
	
	"DividerHorizontal"
	{
		"ControlName"		"ImagePanel"
		"fieldName"			"DividerHorizontal"
		"xpos"				"190"
		"ypos"				"67"
		"wide"				"30"
		"tall"				"1"
		"scaleImage"		"1"
		"visible"			"1"
		"enabled"			"1"
		"fillcolor" 		"145 145 145 255"
		"zpos"				"0"
	}
	
	"Category_Chapter"
	{
		"ControlName"		"Label"
		"fieldName"			"Category_Chapter"
		"xpos"				"5"
		"ypos"				"68"
		"wide"				"180"
		"tall"				"20"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"#L4D_vs_TotalScore"
		"textAlignment"		"east"
		"dulltext"			"1"
		"brighttext"		"0"
		"font"				"BodyText_medium"
		"fgcolor_override"	"MediumGray"
	}
		
	"Category_Chapter_Score"
	{
		"ControlName"		"Label"
		"fieldName"			"Category_Chapter_Score"
		"xpos"				"190"
		"ypos"				"68"
		"wide"				"68"
		"tall"				"20"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"0"
		"textAlignment"		"west"
		"dulltext"			"1"
		"brighttext"		"0"
		"font"				"BodyText_medium"
		"fgcolor_override"	"MediumGray"
	}
	
	"CompletionProgressBar"
	{
		"ControlName"	"CVersusModeLevelProgressBar"
		"fieldName"		"CompletionProgressBar"
		"xpos"			"50"
		"ypos"			"0"
		"wide"			"173"
		"tall"			"60"
		"zpos"			"1"
		"visible"		"1"
		"enabled"		"1"	
		
		"bar_x"			"10"
		"bar_y"			"8"
		"bar_w"			"158"
		"bar_h"			"4"
		"bar_gap"		"3"
		
		"skull_size"	"14"
		"skull_y"		"-5"
		
		"bar_color"					"VersusBrown"
		"bar_localplayer_color"		"VersusSelected"
		"bar_bgcolor"				"VersusDarkGrey"
	}
}