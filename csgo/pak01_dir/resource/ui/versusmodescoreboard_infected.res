"Resource/UI/VersusModeScoreboard_Infected.res"
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
		"image"				"select_pz"
		"drawColor"			"180 180 180 64"	[!$ENGLISH]
		"drawColor"			"180 180 180 255"	[$ENGLISH]
		"zpos"				"0"
	}
	
	//===============================
	// Score categories
	
	"Category_IncapBonus"
 	{
 		"ControlName"		"Label"
 		"fieldName"			"Category_IncapBonus"
		"xpos"				"7"
		"ypos"				"10"
		"wide"				"180"
		"tall"				"20"
 		"autoResize"		"0"
 		"pinCorner"			"0"
 		"visible"			"1"
 		"enabled"			"0"
 		"labelText"			"#L4D_vs_IncapBonus"
 		"textAlignment"		"east"
 		"dulltext"			"1"
 		"brighttext"		"0"
 		"font"				"BodyText_medium"
 		"fgcolor_override"	"MediumGray"
 	}
 	
 	"Category_IncapBonus_Score"
 	{
 		"ControlName"		"Label"
 		"fieldName"			"Category_IncapBonus_Score"
		"xpos"				"190"
		"ypos"				"10"
 		"wide"				"60"
		"tall"				"20"
 		"autoResize"		"0"
 		"pinCorner"			"0"
 		"visible"			"0"
 		"enabled"			"1"
 		"labelText"			""
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
		"xpos"				"35"
		"ypos"				"68"
		"wide"				"150"
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
}