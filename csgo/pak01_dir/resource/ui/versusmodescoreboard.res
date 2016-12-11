"Resource/UI/VersusModeScoreboard.res"
{
	"Background"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"Background"
		"xpos"			"63"
		"ypos"			"0"
		"wide"			"474"
		"tall"			"175"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgmidgrey"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	
	// Title label
	"ModeTitle"
	{
		"ControlName"		"Label"
		"fieldName"		"ModeTitle"
		"xpos"		"0"
		"ypos"		"12"
		"wide"		"600"
		"tall"		"16"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_VSScoreboard_Title"
		"textAlignment"		"center"
		"dulltext"		"0"
		"brighttext"		"0"
		"font"		"MenuTitle"
		"fgcolor_override"	"White"
	}
	
	"BackgroundImageTitle"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"BackgroundImageTitle"
		"xpos"		"68"
		"ypos"		"6"
		"wide"		"463"
		"tall"		"30"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgblack"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	
	"BackgroundImageLeft"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"BackgroundImageLeft"
		"xpos"			"68"
		"ypos"			"35"
		"wide"			"232"
		"tall"			"110"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgblack"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	
	"XboxIconYourTeam"	[$X360]
	{
		"ControlName"		"CIconPanel"
		"fieldName"			"XboxIconYourTeam"
		"xpos"				"75"
		"ypos"				"40"
		"zpos"				"3"
		"wide"				"0"
		"tall"				"16"
		"visible"			"1"
		"enabled"			"1"
		"scaleImage"		"1"
		"icon"				"icon_360_controller_1"
	}
	
	"TeamYours"
	{
		"ControlName"		"Label"
		"fieldName"		"TeamYours"
		"xpos"		"0"		[$X360]
		"ypos"		"2"		[$X360]
		"xpos"		"79"	[$WIN32]
		"ypos"		"40"	[$WIN32]
		"wide"		"200"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_VSScoreboard_YourTeam"
		"textAlignment"		"west"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle_ss"
		"fgcolor_override"	"MediumGray"
		
		"pin_to_sibling"		"XboxIconYourTeam"		[$X360]
		"pin_corner_to_sibling"	"0"						[$X360]
		"pin_to_sibling_corner"	"1"						[$X360]
	}
	
	"BackgroundImageRight"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"BackgroundImageRight"
		"xpos"			"299"
		"ypos"			"35"
		"wide"			"232"
		"tall"			"110"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgblack"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	
	"XboxIconEnemyTeam"	[$X360]
	{
		"ControlName"		"CIconPanel"
		"fieldName"			"XboxIconEnemyTeam"
		"xpos"				"307"
		"ypos"				"40"
		"zpos"				"3"
		"wide"				"0"
		"tall"				"16"
		"visible"			"1"
		"enabled"			"1"
		"scaleImage"		"1"
		"icon"				"icon_360_controller_2"
	}
	
	"TeamEnemy"
	{
		"ControlName"		"Label"
		"fieldName"		"TeamEnemy"
		"xpos"		"0"			[$X360]
		"ypos"		"2"			[$X360]
		"xpos"		"310"		[$WIN32]
		"ypos"		"40"		[$WIN32]
		"wide"		"125"
		"tall"		"20"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"#L4D_VSScoreboard_EnemyTeam"
		"textAlignment"		"west"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"InstructorTitle_ss"
		"fgcolor_override"	"MediumGray"
		
		"pin_to_sibling"		"XboxIconEnemyTeam"			[$X360]
		"pin_corner_to_sibling"	"0"						[$X360]
		"pin_to_sibling_corner"	"1"						[$X360]
	}
		
	"LeftScorePanel"
	{
		"ControlName"		"EditablePanel"
		"fieldName"			"LeftScorePanel"
		"xpos"				"73"
		"ypos"				"50"
		"wide"				"235"
		"tall"				"100"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"	
	}

	"RightScorePanel"
	{
		"ControlName"		"EditablePanel"
		"fieldName"			"RightScorePanel"
		"xpos"				"305"
		"ypos"				"50"
		"wide"				"235"
		"tall"				"100"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"	
	}
	
	"CampaignScoreBackgroundImageLeft"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"CampaignScoreBackgroundImageLeft"
		"xpos"			"68"
		"ypos"			"143"
		"wide"			"232"
		"tall"			"26"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgblack"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	
	"CampaignScore_Yours"
	{
		"ControlName"		"Label"
		"fieldName"			"CampaignScore_Yours"
		"xpos"				"68"
		"ypos"				"143"
		"wide"				"190"
		"tall"				"26"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"#L4D_vs_CampaignScore_Short"
		"textAlignment"		"east"
		"dulltext"			"1"
		"brighttext"		"0"
		"font"				"BodyText_medium"
		"fgcolor_override"	"MediumGray"
	}
	
	"CampaignScore_Yours_Score"
	{
		"ControlName"		"Label"
		"fieldName"		"CampaignScore_Yours_Score"
		"xpos"			"263"
		"ypos"			"143"
		"wide"			"40"
		"tall"			"26"
		"autoResize"		"0"
		"pinCorner"		"0"
		"visible"		"1"
		"enabled"		"1"
		"labelText"		"0"
		"textAlignment"		"west"
		"dulltext"		"1"
		"brighttext"		"0"
		"font"		"BodyText_medium"
		"fgcolor_override"	"MediumGray"
	}
	
	"CampaignScoreBackgroundImageRight"
	{
		"ControlName"	"ScalableImagePanel"
		"fieldName"		"CampaignScoreBackgroundImageRight"
		"xpos"			"299"
		"ypos"			"143"
		"wide"			"232"
		"tall"			"26"
		"visible"		"1"
		"enabled"		"1"
		"scaleImage"	"1"	
		"image"			"../vgui/hud/ScalablePanel_bgblack"
		"zpos"			"-2"
		
		"src_corner_height"		"16"				// pixels inside the image
		"src_corner_width"		"16"
			
		"draw_corner_width"		"8"				// screen size of the corners ( and sides ), proportional
		"draw_corner_height" 	"8"	
	}
	
	"CampaignScore_Enemy"
	{
		"ControlName"		"Label"
		"fieldName"			"CampaignScore_Enemy"
		"xpos"				"300"
		"ypos"				"143"
		"wide"				"190"
		"tall"				"26"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"1"
		"enabled"			"1"
		"labelText"			"#L4D_vs_CampaignScore_Short"
		"textAlignment"		"east"
		"dulltext"			"1"
		"brighttext"		"0"
		"font"				"BodyText_medium"
		"fgcolor_override"	"MediumGray"
	}

	"CampaignScore_Enemy_Score"
	{
		"ControlName"		"Label"
		"fieldName"			"CampaignScore_Enemy_Score"
		"xpos"				"495"
		"ypos"				"143"
		"wide"				"40"
		"tall"				"26"
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
	
	"TieBreakerPanel"
	{
		"ControlName"		"EditablePanel"
		"fieldName"			"TieBreakerPanel"
		"xpos"				"160"
		"ypos"				"50"
		"wide"				"280"
		"tall"				"150"
		"autoResize"		"0"
		"pinCorner"			"0"
		"visible"			"0"
		"enabled"			"1"
		"tabPosition"		"0"
		"padding"			"4"
		"zpos"				"50"
	}
}
