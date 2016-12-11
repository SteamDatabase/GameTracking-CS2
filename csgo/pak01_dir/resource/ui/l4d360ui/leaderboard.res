"Resource/UI/Leaderboard.res"
{
	"Leaderboard"
	{
		"ControlName"					"Frame"
		"fieldName"						"Leaderboard"
		"xpos"							"0"
		"ypos"							"0"
		"wide"							"f0"
		"tall"							"375"  [$X360]
		"tall"							"450"  [$WIN32]
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
	}
								
	"ImgLevelImage"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgLevelImage"
		"xpos"					"c-244"
		"ypos"					"141"
		"wide"					"137"
		"tall"					"69"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"maps/any"
		"scaleImage"			"1"
	}

	"ImgLevelLargeImageFrame"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgLevelLargeImageFrame"
		"xpos"					"c-253"
		"ypos"					"132"         
		"wide"					"177"        
		"tall"					"85"         
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"campaignFrame"
		"scaleImage"			"1"
	}		

	"LblMapName"
	{
		"ControlName"			"Label"
		"fieldName"				"LblMapName"
		"xpos"					"c-245" [$WIN32]
		"xpos"					"c-242" [$X360]
		"ypos"					"105"
		"zpos"					"2"
		"wide"					"139"
		"tall"					"30"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"labelText"				""
		"textAlignment"			"center"
		"Font"					"Default"
	}
	
	"ImgLeftMapArrow" [$X360]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgLeftMapArrow"
		"xpos"					"c-253"
		"ypos"					"114"
		"zpos"					"2"
		"wide"					"11"
		"tall"					"11"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"arrow_left"
		"scaleImage"			"1"
	}
	
	"ImgRightMapArrow" [$X360]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgRightMapArrow"
		"xpos"					"c-110"
		"ypos"					"114"
		"zpos"					"2"
		"wide"					"11"
		"tall"					"11"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"arrow_right"
		"scaleImage"			"1"
	}	
	
	"SearchingIcon"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"SearchingIcon"
		"xpos"					"c214"
		"ypos"					"45"	[$X360]
		"ypos"					"25"	[$WIN32]
		"zpos"					"2"
		"wide"					"32"
		"tall"					"32"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"1"
		"tabPosition"			"0"
		"scaleImage"			"1"
		"image"					"common/l4d_spinner"
	}
		
	// Column headers
	
	"LblRankHeader"
	{
		"ControlName"			"Label"
		"fieldName"				"LblRankHeader"
		"xpos"					"c-94"	[$X360HIDEF || $WIN32]
		"xpos"					"c-104"	[$X360LODEF]
		"ypos"					"105"
		"zpos"					"2"
		"wide"					"100"
		"tall"					"30"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"labelText"				"#L4D360UI_Leaderboard_Rank"
		"textAlignment"			"east"
		"Font"					"Default"
	}
	
	"LblGamerTagHeader"
	{
		"ControlName"			"Label"
		"fieldName"				"LblGamerTagHeader"
		"xpos"					"c26"	[$X360HIDEF || $WIN32]
		"xpos"					"c16"	[$X360LODEF]
		"ypos"					"105"
		"zpos"					"2"
		"wide"					"200"
		"tall"					"30"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"labelText"				"#L4D360UI_Leaderboard_Gamertag"
		"textAlignment"			"west"
		"Font"					"Default"
	}
	
	"LblTimeHeader"
	{
		"ControlName"			"Label"
		"fieldName"				"LblTimeHeader"
		"xpos"					"c220"	[$X360HIDEF || $WIN32]
		"xpos"					"c210"	[$X360LODEF]
		"ypos"					"105"
		"zpos"					"2"
		"wide"					"100"
		"tall"					"30"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"labelText"				"#L4D360UI_Leaderboard_Time"
		"textAlignment"			"west"
		"Font"					"Default"
	}
	
	"ImgTopDivider" [$X360]
	{
		"ControlName"			"Panel"
		"fieldName"				"ImgTopDivider"
		"xpos"					"c-57"		[$X360HIDEF]
		"xpos"					"c-67"		[$X360LODEF]
		"ypos"					"128"
		"zpos"					"1"
		"wide"					"323"
		"tall"					"1"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"bgcolor_override"		"80 80 80 255"
	}

	// top line
	"ImgTopDivider" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgTopDivider"
		"xpos"					"c-100"
		"ypos"					"126"
		"zpos"					"-1"
		"wide"					"370"
		"tall"					"2"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"divider_gradient"
		"scaleImage"			"1"
	}	


	// bottom line
	"ImgBottomDivider" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgBottomDivider"
		"xpos"					"c-100"
		"ypos"					"414"
		"zpos"					"-1"
		"wide"					"370"
		"tall"					"2"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"divider_gradient"
		"scaleImage"			"1"
	}
			
	"LblNoEntriesFound"
	{
		"ControlName"					"Label"
		"fieldName"						"LblNoEntriesFound"
		"xpos"							"c-50" [$WIN32]
		"ypos"							"130"  [$WIN32]
		"xpos"							"c-50" [$X360]
		"ypos"							"130"  [$X360]
		"wide"							"290"
		"tall"							"60" [$WIN32]
		"tall"							"60"  [$X360]
		"zpos"							"2"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1" 
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						"#L4D360UI_Leaderboard_No_Times"
		"textAlignment"					"west"
		"Font"							"Default"
		"wrap"							"1"
	}
	
	"PanelList"
	{
		"ControlName"			"GenericPanelList"
		"fieldName"				"PanelList"
		"xpos"					"c-60"		[$X360HIDEF || $WIN32]
		"xpos"					"c-70"		[$X360LODEF]
		"ypos"					"126"	
		"zpos"					"0"
		"wide"					"340"		[$WIN32]
		"wide"					"330"		[$X360]
		"tall"					"290"		[$WIN32]
		"tall"					"228"		[$X360LODEF]
		"tall"					"244"		[$X360HIDEF]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"bgcolor_override" 		"32 32 32 255"
		"NoWrap"				"1"
		"panelBorder"			"2"
		"navRight"				"BtnJoinSelected"	[$WIN32]
		"navLeft"				"DrpCreateGame"		[$WIN32]
		"navDown"				"DrpCreateGame"		[$WIN32]
	}
	
	"ImgBottomDivider" [$X360]
	{
		"ControlName"			"Panel"
		"fieldName"				"ImgBottomDivider"
		"xpos"					"c-57"		[$X360HIDEF]
		"xpos"					"c-67"		[$X360LODEF]
		"ypos"					"328"		[$X360LODEF]
		"ypos"					"345"		[$X360HIDEF]
		"zpos"					"1"
		"wide"					"323"
		"tall"					"1"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"bgcolor_override"		"80 80 80 255"
	}
	
	"LblLeftTriggerIcon" [$X360]
	{
		"ControlName"					"Label"
		"fieldName"						"LblLeftTriggerIcon"
		"xpos"							"c-288"		[!$ENGLISH && $X360LODEF]
		"xpos"							"c-285"		[!$ENGLISH && $X360HIDEF]
		"xpos"							"c-254"		[$ENGLISH]
		"ypos"							"c50"
		"wide"							"50"
		"tall"							"30"
		"zpos"							"2"
		"autoResize"					"1"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"Font"							"GameUIButtonsMini"
		"labelText"						"#GameUI_Icons_L_TRIGGER"
	}
	
	"LblJumpToTop" [$X360]
	{
		"ControlName"					"Label"
		"fieldName"						"LblJumpToTop"
		"xpos"							"c-262"		[!$ENGLISH && $X360LODEF]
		"xpos"							"c-260"		[!$ENGLISH && $X360HIDEF]
		"xpos"							"c-228"		[$ENGLISH]
		"ypos"							"c50"
		"wide"							"250"
		"tall"							"30"
		"zpos"							"2"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1" 
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						"#L4D360UI_Leaderboard_Jump_To_Top"
		"textAlignment"					"west"
		"Font"							"DefaultBold"
	}
	
	"LblRightTriggerIcon" [$X360]
	{
		"ControlName"					"Label"
		"fieldName"						"LblRightTriggerIcon"
		"xpos"							"c-288"		[!$ENGLISH && $X360LODEF]
		"xpos"							"c-285"		[!$ENGLISH && $X360HIDEF]
		"xpos"							"c-254"		[$ENGLISH]
		"ypos"							"c78"
		"wide"							"50"
		"tall"							"30"
		"zpos"							"2"
		"autoResize"					"1"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"Font"							"GameUIButtonsMini"
		"labelText"						"#GameUI_Icons_R_TRIGGER"
	}
	
	"LblJumpToMe" [$X360]
	{
		"ControlName"					"Label"
		"fieldName"						"LblJumpToMe"
		"xpos"							"c-262"		[!$ENGLISH && $X360LODEF]
		"xpos"							"c-260"		[!$ENGLISH && $X360HIDEF]
		"xpos"							"c-228"		[$ENGLISH]
		"ypos"							"c78"
		"wide"							"200"
		"tall"							"30"
		"zpos"							"2"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1" 
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						"#L4D360UI_Leaderboard_Jump_To_Me"
		"textAlignment"					"west"
		"Font"							"DefaultBold"
	}
		
	"ImgGoldMedal"
	{
		"ControlName"					"ImagePanel"
		"fieldName"						"ImgGoldMedal"
		"xpos"							"c-244"
		"ypos"							"c-12"	[$WIN32]
		"ypos"							"c-10"	[$X360]
		"zpos"							"2"
		"wide"							"20"
		"tall"							"20"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"image"							"hud/survival_medal_gold"
		"scaleImage"					"1"
	}
	
	"LblGoldMedalTime"
	{
		"ControlName"					"Label"
		"fieldName"						"LblGoldMedalTime"
		"xpos"							"c-220"
		"ypos"							"c-12"	[$WIN32]
		"ypos"							"c-10"	[$X360]
		"wide"							"50"
		"tall"							"20"
		"zpos"							"2"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1" 
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						"0:00"
		"textAlignment"					"west"
		"Font"							"Default"
	}
	
	"ImgSilverMedal"
	{
		"ControlName"					"ImagePanel"
		"fieldName"						"ImgSilverMedal"
		"xpos"							"c-244"
		"ypos"							"c5"	[$WIN32]
		"ypos"							"c7"	[$X360]
		"zpos"							"2"
		"wide"							"20"
		"tall"							"20"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"image"							"hud/survival_medal_silver"
		"scaleImage"					"1"
	}
	
	"LblSilverMedalTime"
	{
		"ControlName"					"Label"
		"fieldName"						"LblSilverMedalTime"
		"xpos"							"c-220"
		"ypos"							"c5"	[$WIN32]
		"ypos"							"c7"	[$X360]
		"wide"							"50"
		"tall"							"20"
		"zpos"							"2"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1" 
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						"0:00"
		"textAlignment"					"west"
		"Font"							"Default"
	}
	
	"ImgBronzeMedal"
	{
		"ControlName"					"ImagePanel"
		"fieldName"						"ImgBronzeMedal"
		"xpos"							"c-244"
		"ypos"							"c22"	[$WIN32]
		"ypos"							"c24"	[$X360]
		"zpos"							"2"
		"wide"							"20"
		"tall"							"20"
		"pinCorner"						"0"
		"visible"						"1"
		"enabled"						"1"
		"tabPosition"					"0"
		"image"							"hud/survival_medal_bronze"
		"scaleImage"					"1"
	}
	
	"LblBronzeMedalTime"
	{
		"ControlName"					"Label"
		"fieldName"						"LblBronzeMedalTime"
		"xpos"							"c-220"
		"ypos"							"c22"	[$WIN32]
		"ypos"							"c24"	[$X360]
		"wide"							"50"
		"tall"							"20"
		"zpos"							"2"
		"autoResize"					"0"
		"pinCorner"						"0"
		"visible"						"1" 
		"enabled"						"1"
		"tabPosition"					"0"
		"labelText"						"0:00"
		"textAlignment"					"west"
		"Font"							"Default"
	}
	
	// Campaign dropdown
	"DrpMission" [$WIN32]
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpMission"
		"xpos"					"c-265"
		"ypos"					"290"
		"zpos"					"1"
		"wide"					"180"
		"tall"					"15"
		"visible"				"1"
		"enabled"				"1"
		"navUp"					"BtnExit"
		"navDown"				"DrpChapter"
		
		//button and label
		"BtnDropButton"
		{
			"ControlName"					"L4D360HybridButton"
			"fieldName"						"BtnDropButton"
			"xpos"							"0"
			"ypos"							"0"
			"zpos"							"2"
			"wide"							"180"
			"wideatopen"					"150"
			"tall"							"15"
			"autoResize"					"1"
			"pinCorner"						"0"
			"visible"						"1"
			"enabled"						"1"
			"tabPosition"					"0"
			"labelText"						"#L4D360UI_GameSettings_Mission"
			"tooltiptext"					"#L4D360UI_Leaderboard_Tooltip_Mission"
			"disabled_tooltiptext"			""
			"style"							"DropDownButton"
			"command"						"FlmMissionSurvival"
			"ActivationType"				"1" [$X360]
		}
	}
	
	// Campaign flyout	
	"FlmMissionSurvival" [$WIN32]
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmMissionSurvival"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnHospital"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownMissionSurvival.res"
	}
	
	// Chapter Dropdown
	"DrpChapter" [$WIN32]
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpChapter"
		"xpos"					"c-265"
		"ypos"					"305"
		"zpos"					"1"
		"wide"					"180"
		"tall"					"15"
		"visible"				"1"
		"enabled"				"1"
		"navUp"					"DrpMission"
		"navDown"				"BtnFindServer"
		
		//button and label
		"BtnDropButton"
		{
			"ControlName"					"L4D360HybridButton"
			"fieldName"						"BtnDropButton"
			"xpos"							"0"
			"ypos"							"0"
			"zpos"							"2"
			"wide"							"180"
			"wideatopen"					"150"
			"tall"							"15"
			"autoResize"					"1"
			"pinCorner"						"0"
			"visible"						"1"
			"enabled"						"1"
			"tabPosition"					"0"
			"labelText"						"#L4D360UI_GameSettings_Chapter"
			"tooltiptext"					"#L4D360UI_Leaderboard_Tooltip_Chapter"
			"disabled_tooltiptext"			""
			"style"							"DropDownButton"
			"command"						""
			"ActivationType"				"1" [$X360]
		}
	}
	
	//flyouts		
	"FlmChapterXXautogenerated" [$WIN32]
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmChapterFlyout"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnChapter1"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownChapter.res"
	}

	"IconForwardArrow" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconForwardArrow"
		"xpos"					"c-280"
		"ypos"					"330"
		"wide"					"15"       
		"tall"					"15"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_arrow_right"
		"scaleImage"			"1"
	}

	"BtnFindServer" [$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnFindServer"
		"command"				"FindGameForThisChapter"
		"xpos"					"c-265"
		"ypos"					"330"
		"wide"					"180"
		"tall"					"15"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"DrpChapter"
		"navDown"				"BtnExit"
		"tooltiptext"			"#L4D360UI_Leaderboard_Join_Game_Tip"
		"disabled_tooltiptext"	"#L4D360UI_Leaderboard_Join_Game_Tip_Disabled"
		"labelText"				"#L4D360UI_Leaderboard_Join_Game"
		"style"					"MainMenuSmallButton"
		"allcaps"				"1"
	}
	
	
	"IconBackArrow" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconBackArrow"
		"xpos"					"c-280"		
		"ypos"					"345"
		"wide"					"15"
		"tall"					"15"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_arrow_left"
		"scaleImage"			"1"
	}
	
	"BtnExit" [$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnExit"
		"command"				"Exit"
		"xpos"					"c-265"
		"ypos"					"345"
		"wide"					"180"
		"tall"					"15"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"navUp"					"BtnFindServer"
		"navDown"				"DrpMission"
		"tooltiptext"			""
		"labelText"				"#L4D360UI_Back_Caps"
		"style"					"MainMenuSmallButton"
	}
	
	"FlmPlayerFlyout" [$WIN32]
	{
		"ControlName"		"FlyoutMenu"
		"fieldName"			"FlmPlayerFlyout"
		"visible"			"0"
		"wide"				"0"
		"tall"				"0"
		"zpos"				"3"
		"InitialFocus"		"BtnSendMessage"
		"ResourceFile"		"resource/UI/L4D360UI/DropDownFoundGamesPlayer.res"
	}
	
	"FlmPlayerFlyout_NotFriend" [$WIN32]
	{
		"ControlName"		"FlyoutMenu"
		"fieldName"			"FlmPlayerFlyout_NotFriend"
		"visible"			"0"
		"wide"				"0"
		"tall"				"0"
		"zpos"				"3"
		"InitialFocus"		"BtnViewSteamID"
		"ResourceFile"		"resource/UI/L4D360UI/DropDownFoundGamesPlayer_NotFriend.res"
	}
}