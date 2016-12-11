"Resource/UI/VersusModeResults.res"
{
	"BackgroundImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"BackgroundImage"
		"xpos"			"0"
		"ypos"			"0"
		"wide"			"354" [$ENGLISH]
		"wide"			"364" [!$ENGLISH]
		"tall"			"115"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineGrey"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
		
	"StatBreakdownHighlightImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"StatBreakdownHighlightImage"
		"xpos"		"0"
		"ypos"		"70"
		"wide"			"354" [$ENGLISH]
		"wide"			"364" [!$ENGLISH]
		"tall"		"45"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineRed"
		"zpos"			"-1"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}

	"ModeTitle"
	{
		"ControlName"		"Label"
		"fieldName"		"ModeTitle"
		"xpos"		"13"
		"ypos"		"11"
		"wide"		"300" [$ENGLISH]
		"wide"		"344" [!$ENGLISH]
		"tall"		"24"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_VSScoreboard_Title"
		"textAlignment"		"north-west"
		"dulltext"		"0"
		"brighttext"		"0"
		"font"		"MenuTitle"
		"fgcolor_override"	"White"
	}

	"TeamYours"
	{
		"ControlName"		"Label"
		"fieldName"		"TeamYours"
		"xpos"		"25"
		"ypos"		"30"
		"wide"		"125" [$ENGLISH]
		"wide"		"132" [!$ENGLISH]
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_VSScoreboard_YourTeam"
		"textAlignment"		"center"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle_ss"
		"fgcolor_override"	"White"
	}

	"TeamEnemy"
	{
		"ControlName"		"Label"
		"fieldName"		"TeamEnemy"
		"xpos"		"200" [$ENGLISH]
		"xpos"		"207" [!$ENGLISH]
		"ypos"		"30"
		"wide"		"125" [$ENGLISH]
		"wide"		"132" [!$ENGLISH]
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_VSScoreboard_EnemyTeam"
		"textAlignment"		"center"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle_ss"
		"fgcolor_override"	"White"
	}

	"TeamYourScoreSurvivors"
	{
		"ControlName"		"Label"
		"fieldName"		"TeamYourScoreSurvivors"
		"xpos"		"25"
		"ypos"		"50"
		"wide"		"125" [$ENGLISH]
		"wide"		"132" [!$ENGLISH]
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%YourSurvivor%"
		"textAlignment"		"north"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle"
		"fgcolor_override"	"MediumGray"
	}

	"TeamEnemyScoreSurvivors"
	{
		"ControlName"		"Label"
		"fieldName"		"TeamEnemyScoreSurvivors"
		"xpos"		"200" [$ENGLISH]
		"xpos"		"207" [!$ENGLISH]
		"ypos"		"50"
		"wide"		"125" [$ENGLISH]
		"wide"		"132" [!$ENGLISH]
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"%EnemySurvivor%"
		"textAlignment"		"north"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle"
		"fgcolor_override"	"MediumGray"
	}
	
	"YourTeamHighlightImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"YourTeamHighlightImage"
		"xpos"		"25"
		"ypos"		"43"
		"wide"		"125" [$ENGLISH]
		"wide"		"132" [!$ENGLISH]
		"tall"		"32"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineRed"
		"zpos"			"-1"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	
	"EnemyTeamHighlightImage"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"EnemyTeamHighlightImage"
		"xpos"		"200" [$ENGLISH]
		"xpos"		"207" [!$ENGLISH]
		"ypos"		"43"
		"wide"		"125" [$ENGLISH]
		"wide"		"132" [!$ENGLISH]
		"tall"		"32"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgBlack_outlineRed"
		"zpos"			"-1"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	
	"TeamWinLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"TeamWinLabel"
		"xpos"				"15"
		"ypos"				"72"
		"wide"				"324" [$ENGLISH]
		"wide"				"334" [!$ENGLISH]
		"tall"				"30"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"#L4D_VSScoreboard_Distance"
		"textAlignment"		"center"
		"dulltext"			"1"
		"brighttext"		"0"
		"font"				"InstructorTitle"
		"fgcolor_override"	"MediumGray"
	}	
	
	"TeamFlipExplanationLabel"
	{
		"ControlName"		"Label"
		"fieldName"			"TeamFlipExplanationLabel"
		"xpos"				"0"
		"ypos"				"86"
		"wide"				"354"
		"tall"				"30"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"labelText"			"You will play Survivors first in the next chapter."
		"textAlignment"		"center"
		"dulltext"			"1"
		"brighttext"		"0"
		"font"				"InstructorTitle_ss"
		"fgcolor_override"	"MediumGray"
	}
}
