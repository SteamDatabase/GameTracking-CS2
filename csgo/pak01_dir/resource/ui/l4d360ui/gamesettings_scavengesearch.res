"Resource/UI/GameSettings_ScavengeSearch.res"
{
	"GameSettings"
	{
		"ControlName"				"Frame"
		"fieldName"					"GameSettings"
		"xpos"						"0"
		"ypos"						"0"
		"wide"						"f0"
		"tall"						"260"
		"autoResize"				"0"
		"pinCorner"					"0"
		"visible"					"1"
		"enabled"					"1"
		"tabPosition"				"0"
	}
	
	"ImgBackground"
	{
		"ControlName"			"L4DMenuBackground"
		"fieldName"				"ImgBackground"
		"xpos"					"0"
		"ypos"					"179"
		"zpos"					"-1"
		"wide"					"f0"
		"tall"					"144"
		"autoResize"			"0"
		"pinCorner"				"0"
		"visible"				"1"		[$WIN32]
		"visible"				"0"		[$X360]
		"enabled"				"1"
		"tabPosition"			"0"
		"fillColor"				"0 0 0 0"
	} 
		
	"ImgLevelImage"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgLevelImage"
		"xpos"					"c51"
		"ypos"					"125"
		"wide"					"200"
		"tall"					"100"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"maps/any"
		"scaleImage"			"1"
	}
	"ImgLevelImageFrame"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"ImgLevelImageFrame"
		"xpos"					"c45"
		"ypos"					"113"
		"wide"					"246"
		"tall"					"123"
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"campaignFrame"
		"scaleImage"			"1"
	}
	
	// Campaign dropdown
	"DrpMission"
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpMission"
		"xpos"					"c-250"	
		"ypos"					"115"
		"zpos"					"1"
		"wide"					"280"
		"tall"					"15"			[$WIN32]
		"tall"					"20"			[$X360]
		"visible"				"1"
		"enabled"				"1"
		"navUp"					"BtnJoinStart"	[$X360]
		"navUp"					"BtnCancel"		[$WIN32]
		"navDown"				"DrpMissionExtended"
		
		//button and label
		"BtnDropButton"
		{
			"ControlName"					"L4D360HybridButton"
			"fieldName"						"BtnDropButton"
			"xpos"							"0"
			"ypos"							"0"
			"zpos"							"2"
			"wide"							"280"
			"wideatopen"					"160"
			"tall"							"15"	[$WIN32]
			"tall"							"20"	[$X360]
			"autoResize"					"1"
			"pinCorner"						"0"
			"visible"						"1"
			"enabled"						"1"
			"tabPosition"					"0"
			"labelText"						"#L4D360UI_GameSettings_Mission"
			"tooltiptext"					"#L4D360UI_GameSettings_Tooltip_Mission"
			"disabled_tooltiptext"			"#L4D360UI_GameSettings_Tooltip_Mission_Disabled"
			"style"							"DropDownButton"
			"command"						"FlmMissionScavenge"
			"ActivationType"				"1" [$X360]
			"EnableCondition"					"Never" [$DEMO]
		}
	}
	
	// Campaign flyout	
	"FlmMissionScavenge"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmMissionScavenge"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnHospital"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownMissionScavenge.res"
	}
	
	"DrpMissionExtended"
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpMissionExtended"
		"xpos"					"c-250"
		"ypos"					"115"		[$WIN32]
		"ypos"					"115"		[$X360]
		"zpos"					"1"
		"wide"					"280"
		"tall"					"15"		[$WIN32]
		"tall"					"20"		[$X360]
		"visible"				"0"
		"enabled"				"1"
		"navUp"					"DrpMission"
		"navDown"				"DrpChapter"
		
		//button and label
		"BtnDropButton"
		{
			"ControlName"					"L4D360HybridButton"
			"fieldName"						"BtnDropButton"
			"xpos"							"0"
			"ypos"							"0"
			"zpos"							"2"
			"wide"							"280"
			"wideatopen"					"160"
			"tall"							"15"		[$WIN32]
			"tall"							"20"		[$X360]
			"autoResize"					"1"
			"pinCorner"						"0"
			"visible"						"1"
			"enabled"						"1"
			"tabPosition"					"0"
			"labelText"						"#L4D360UI_GameSettings_Mission"
			"tooltiptext"					"#L4D360UI_GameSettings_Tooltip_Mission"
			"disabled_tooltiptext"			"#L4D360UI_GameSettings_Tooltip_Mission_Disabled"
			"style"							"DropDownButton"
			"command"						"FlmMissionScavengeExtended"
			"ActivationType"				"1" [$X360]
		}
	}
	
	"FlmMissionScavengeExtended"
	{
		"ControlName"			"FlyoutMenu"
		"fieldName"				"FlmMissionScavengeExtended"
		"visible"				"0"
		"wide"					"0"
		"tall"					"0"
		"zpos"					"4"
		"InitialFocus"			"BtnHospital"
		"ResourceFile"			"resource/UI/L4D360UI/DropDownMissionScavengeExtended.res"
	}

	// Chapter Dropdown
	"DrpChapter"
	{
		"ControlName"			"DropDownMenu"
		"fieldName"				"DrpChapter"
		"xpos"					"c-250"
		"ypos"					"135"		[$WIN32]
		"ypos"					"140"		[$X360]
		"zpos"					"1"
		"wide"					"280"
		"tall"					"15"		[$WIN32]
		"tall"					"20"		[$X360]
		"visible"				"1"
		"enabled"				"1"
		"navUp"					"DrpMissionExtended"
		"navDown"				"BtnCreateLobby"
		
		//button and label
		"BtnDropButton"
		{
			"ControlName"					"L4D360HybridButton"
			"fieldName"						"BtnDropButton"
			"xpos"							"0"
			"ypos"							"0"
			"zpos"							"2"
			"wide"							"280"
			"wideatopen"					"160"
			"tall"							"15"	[$WIN32]
			"tall"							"20"	[$X360]
			"autoResize"					"1"
			"pinCorner"						"0"
			"visible"						"1"
			"enabled"						"1"
			"tabPosition"					"0"
			"labelText"						"#L4D360UI_GameSettings_Chapter"
			"tooltiptext"					"#L4D360UI_GameSettings_Tooltip_Chapter"
			"disabled_tooltiptext"			"#L4D360UI_GameSettings_Tooltip_Chapter_Disabled"
			"style"							"DropDownButton"
			"command"						""
			"ActivationType"				"1"		[$X360]
		}
	}
	
	//flyouts		
	"FlmChapterXXautogenerated"
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

	"BtnCreateLobby"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCreateLobby"
		"xpos"					"c-250"
		"ypos"					"155"		[$WIN32]
		"ypos"					"165"		[$X360]	
		"zpos"					"0"
		"wide"					"220"
		"tall"					"15"		[$WIN32]
		"tall"					"20"		[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"DrpChapter"
		"navDown"				"BtnJoinAnywhere"
		"labelText"				"#L4D360UI_Join_Create"
		"tooltiptext"			"#L4D360UI_GameSettings_Tooltip_Create_Lobby"
		"disabled_tooltiptext"	"#L4D360UI_GameSettings_Tooltip_Create_Lobby"
		"style"					"DefaultButton"
		"command"				"Create"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
	}
	
    "IconForwardArrow_JoinAny"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconForwardArrow_JoinAny"
		"xpos"					"c-265"	[$WIN32]
		"xpos"					"c-275"	[$X360]
		"ypos"					"175"	[$WIN32]
		"ypos"					"190"	[$X360]
		"wide"					"15" 	[$WIN32]
		"tall"					"15" 	[$WIN32]
		"wide"					"20" 	[$X360]
		"tall"					"20" 	[$X360]
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_arrow_right"
		"scaleImage"			"1"
	}
	"BtnJoinAnywhere"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnJoinAnywhere"
		"xpos"					"c-250"
		"ypos"					"175"	[$WIN32]
		"ypos"					"190"	[$X360]
		"zpos"					"0"
		"wide"					"220"
		"tall"					"15"		[$WIN32]
		"tall"					"20"		[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"BtnCreateLobby"
		"navDown"				"BtnJoinStart"
		"labelText"				"#L4D360UI_Join_Anywhere"
		"tooltiptext"			"#L4D360UI_GameSettings_Tooltip_Join_Anywhere"
		"disabled_tooltiptext"	"#L4D360UI_GameSettings_Tooltip_Join_Anywhere_Disabled"
		"style"					"DefaultButton"
		"command"				"JoinAny"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
	}
	
	"IconForwardArrow_JoinStart"
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconForwardArrow_JoinStart"
		"xpos"					"c-265"	[$WIN32]
		"xpos"					"c-275"	[$X360]
		"ypos"					"195"	[$WIN32]
		"ypos"					"215"	[$X360]
		"wide"					"15" 	[$WIN32]
		"tall"					"15" 	[$WIN32]
		"wide"					"20" 	[$X360]
		"tall"					"20" 	[$X360]
		"scaleImage"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"0"
		"image"					"icon_button_arrow_right"
		"scaleImage"			"1"
	}	
	"BtnJoinStart"
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnJoinStart"
		"xpos"					"c-250"
		"ypos"					"195"		[$WIN32]
		"ypos"					"215"		[$X360]
		"zpos"					"0"
		"wide"					"220"
		"tall"					"15"		[$WIN32]
		"tall"					"20"		[$X360]
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"1"
		"enabled"				"1"
		"tabPosition"			"1"
		"wrap"					"1"
		"navUp"					"BtnJoinAnywhere"
		"navDown"				"DrpMission"		[$X360]
		"navDown"				"BtnCancel"			[$WIN32]
		"labelText"				"#L4D360UI_Join_At_Start"
		"tooltiptext"			"#L4D360UI_GameSettings_Tooltip_Join_At_Start"
		"disabled_tooltiptext"	"#L4D360UI_GameSettings_Tooltip_Join_At_Start_Disabled"
		"style"					"DefaultButton"
		"command"				"Done"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
	}

	"IconBackArrow" [$WIN32]
	{
		"ControlName"			"ImagePanel"
		"fieldName"				"IconBackArrow"
		"xpos"					"c-265"
		"ypos"					"215"
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
	"BtnCancel" [$WIN32]
	{
		"ControlName"			"L4D360HybridButton"
		"fieldName"				"BtnCancel"
		"xpos"					"c-250"
		"ypos"					"215"
		"zpos"					"0"
		"wide"					"220"
		"tall"					"15"
		"autoResize"			"1"
		"pinCorner"				"0"
		"visible"				"0"
		"enabled"				"1"
		"tabPosition"			"0"
		"wrap"					"1"
		"navUp"					"BtnJoinStart"
		"navDown"				"DrpMission"
		"labelText"				"#L4D360UI_Back_Caps"
		"tooltiptext"			"#L4D360UI_Tooltip_Back"
		"style"					"DefaultButton"
		"command"				"Back"
		EnabledTextInsetX		"2"
		DisabledTextInsetX		"2"
		FocusTextInsetX			"2"
		OpenTextInsetX			"2"
	}
}
